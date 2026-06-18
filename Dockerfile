FROM golang:1.25-bookworm AS server-builder

# Install C build tools needed for v8go (JavaScript engine used by Fider for SSR)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libc6-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

# Copy dependency files first — Docker caches this layer
# If go.mod and go.sum haven't changed, it won't re-download modules
COPY app/go.mod app/go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY app/ ./

# Build the Go binary — strips debug info with -s -w for smaller size
RUN make build-server

FROM node:22-bookworm AS ui-builder

WORKDIR /ui

# Copy package files first for better layer caching
COPY app/package.json app/package-lock.json ./
RUN npm ci --maxsockets 1

# Copy source and build frontend assets
COPY app/ .
RUN make build-ssr
RUN make build-ui

FROM debian:bookworm-slim

# Install CA certificates for HTTPS calls
RUN apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Create a non-root user and group for security
# Never run containers as root in production
RUN groupadd -r fider && useradd -r -g fider fider

# Copy only what's needed to run — nothing else
COPY --from=server-builder /server/migrations ./migrations
COPY --from=server-builder /server/views ./views
COPY --from=server-builder /server/locale ./locale
COPY --from=server-builder /server/static ./static
COPY --from=server-builder /server/LICENSE .
COPY --from=server-builder /server/fider .

COPY --from=ui-builder /ui/favicon.png .
COPY --from=ui-builder /ui/dist ./dist
COPY --from=ui-builder /ui/robots.txt .
COPY --from=ui-builder /ui/ssr.js .

# Give the non-root user ownership of the app directory
RUN chown -R fider:fider /app

# Switch to non-root user
USER fider

EXPOSE 3000

HEALTHCHECK --interval=10s --timeout=5s --retries=3 \
    CMD ./fider ping

# Run migrations then start the server
CMD ./fider migrate && ./fider