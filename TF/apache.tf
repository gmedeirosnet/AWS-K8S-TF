# Security Group for Apache Instance
resource "aws_security_group" "apache_sg" {
  name        = "apache-security-group"
  description = "Allow HTTP traffic from the WAF"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic only from the WAF's VPC or internal subnet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block] # Allow from within the VPC instead of depending on the specific WAF IP
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "apache-sg"
    Project = var.project_label
  }
}

resource "aws_instance" "hello" {
  ami                    = "ami-08c40ec9ead489470" # Ubuntu 22.04 LTS AMI (us-east-1)
  instance_type          = "t3.micro"
  subnet_id              = element(aws_subnet.private_subnets[*].id, 0) # Use the first private subnet
  key_name               = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.apache_sg.id]

  tags = {
    Name    = "Hello"
    Project = var.project_label
  }

  # Use cloud-init to install Apache
  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              systemctl enable apache2
              systemctl start apache2
              echo "<h1>Hello from Apache Server!</h1>" > /var/www/html/index.html
              EOF
}
