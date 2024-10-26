Objectives:
    - Learning GIT
    - Learning Terraform
    - Learning Design infra-structure on AWS
    - Build infra-structure on AWS with Terraform

TERRAFORM STRUCTURE:
    terraform/
    ├── main.tf                       # Main Terraform configuration file (non-network resources)
    ├── network.tf                    # Network configuration (VPC, subnets, routing)
    ├── variables.tf                  # Terraform variables
    ├── terraform.tfvars              # Values for Terraform variables
    └── outputs.tf                    # Terraform outputs
