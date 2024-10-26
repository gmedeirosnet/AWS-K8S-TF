# VPC Resource
resource "aws_vpc" "main" {
  cidr_block             = var.vpc_cidr
  enable_dns_support     = true
  enable_dns_hostnames   = true

  tags = {
    Name        = var.vpc_name
    Environment = var.environment
    Project     = var.project_label   # Include the gmedeiros label
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.vpc_name}-public-subnet"
    Project = var.project_label        # Include the gmedeiros label
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "${var.vpc_name}-internet-gateway"
    Project = var.project_label        # Include the gmedeiros label
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "${var.vpc_name}-public-route-table"
    Project = var.project_label        # Include the gmedeiros label
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}
