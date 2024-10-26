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

# Public Subnet CIDR
variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Availability Zone
variable "availability_zone" {
  description = "The availability zone for the public subnet"
  type        = string
  default     = "us-east-1a"
}

# Project Label (e.g., gmedeiros)
variable "project_label" {
  description = "The project label to include in AWS resource tags"
  type        = string
  default     = "gmedeiros"
}
