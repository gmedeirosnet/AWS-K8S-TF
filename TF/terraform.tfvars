aws_region          = "us-east-1"
vpc_cidr            = "10.0.0.0/16"
vpc_name            = "production-vpc"
environment         = "Production"
public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
project_label       = "gmedeiros"