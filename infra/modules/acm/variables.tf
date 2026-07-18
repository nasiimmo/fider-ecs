variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "domain_name" {
  description = "The domain name for the ACM certificate"
  type        = string
}

variable "name_prefix" {
  description = "The prefix for naming resources"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for the domain"
  type        = string
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token for DNS validation"
  type        = string
  sensitive   = true
}