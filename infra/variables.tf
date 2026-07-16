variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-2"
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "fider-ecs"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "nasiimmo.com"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "fider-ecs"
}

variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "fiderdb"
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  default     = "admin"
}


variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "image_tag" {
  description = "Docker image tag to deploy"
  type        = string
}