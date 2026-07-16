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