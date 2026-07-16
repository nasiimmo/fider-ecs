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

variable "private_subnet_ids" {
  description = "A list of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "db_name" {
  description = "The name of the database to create"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}

variable "db_password" {
  description = "The password for the database"
  type        = string
  sensitive   = true
}

variable "ecs_security_group_id" {
  description = "The security group ID for ECS tasks that need access to the RDS instance"
  type        = string
}
