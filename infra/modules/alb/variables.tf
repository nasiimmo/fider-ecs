variable "name_prefix" {
  description = "The prefix for naming resources"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the RDS instance will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the RDS instance"
  type        = list(string)
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate for the RDS instance"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "The Cloudflare zone ID for DNS record creation"
  type        = string
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token for DNS record creation"
  type        = string
}