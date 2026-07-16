terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.53.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-nasiim"
    key    = "fider-ecs/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-2"
}