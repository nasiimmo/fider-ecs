variable "domain_name" {
  description = "Domain name for SES verification"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare zone ID for DNS records"
  type        = string
}

variable "cloudflare_api_token" {
  description = "Cloudflare API token"
  type        = string
  sensitive   = true
}

variable "admin_email" {
  description = "Admin email address for SES verification"
  type        = string
}
