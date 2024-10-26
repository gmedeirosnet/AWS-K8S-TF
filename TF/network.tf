# VPC Resource
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
    Project     = var.project_label # Include the gmedeiros label
  }
}

# Create Public Subnets in Multiple Availability Zones
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.vpc_name}-public-subnet-${count.index + 1}"
    Project = var.project_label # Include the gmedeiros label
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.vpc_name}-internet-gateway"
    Project = var.project_label # Include the gmedeiros label
  }
}

# Route Table for Public Subnets
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.vpc_name}-public-route-table"
    Project = var.project_label # Include the gmedeiros label
  }
}

# Associate Route Table with Public Subnets
resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
