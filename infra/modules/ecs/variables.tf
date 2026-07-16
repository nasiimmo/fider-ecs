variable "name_prefix" {
  description = "The prefix for naming resources"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "The security group ID for the ALB"
  type        = string
}

variable "target_group_arn" {
  description = "The ARN of the target group for the ALB"
  type        = string
}

variable "execution_role_arn" {
  description = "The ARN of the execution role for ECS tasks"
  type        = string
}

variable "ecr_repository_url" {
  description = "The URL of the ECR repository"
  type        = string
}

variable "image_tag" {
  description = "The tag of the Docker image to deploy"
  type        = string
}

variable "db_endpoint" {
  description = "The endpoint of the RDS database"
  type        = string
}

variable "db_port" {
  description = "The port of the RDS database"
  type        = number
}

variable "db_name" {
  description = "The name of the RDS database"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS database"
  type        = string
  sensitive   = true
}

variable "jwt_secret" {
  description = "The secret key for JWT authentication"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "The domain name for the application"
  type        = string
}