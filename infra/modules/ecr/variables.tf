variable "repository_name" {
  description = "The name of the ECR repository"
  type        = string
}
variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "name_prefix" {
  description = "The prefix for naming resources"
  type        = string
}

