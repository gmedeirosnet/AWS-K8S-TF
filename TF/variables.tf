# AWS region
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# VPC CIDR block
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# VPC Name
variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
  default     = "my-vpc"
}

# Environment Tag
variable "environment" {
  description = "Environment tag (e.g., Dev, Staging, Prod)"
  type        = string
  default     = "Dev"
}

# Public Subnets CIDR Blocks
variable "public_subnet_cidrs" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Private Subnets CIDR Blocks
variable "private_subnet_cidrs" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

# Availability Zones
variable "availability_zones" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Project Label (e.g., gmedeiros)
variable "project_label" {
  description = "The project label to include in AWS resource tags"
  type        = string
  default     = "gmedeiros"
}
