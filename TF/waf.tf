# Security Group for WAF Instance
resource "aws_security_group" "waf_sg" {
  name        = "waf-security-group"
  description = "Allow inbound HTTP and SSH traffic for WAF"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic from the internet
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH access from the internet
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "waf-sg"
    Project = var.project_label
  }
}

# WAF Instance (NGINX Load Balancer)
resource "aws_instance" "waf" {
  ami                         = "ami-08c40ec9ead489470" # Ubuntu 22.04 LTS AMI (us-east-1)
  instance_type               = "t3.micro"
  subnet_id                   = element(aws_subnet.public_subnets[*].id, 0) # Use the first public subnet
  key_name                    = aws_key_pair.my_key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.waf_sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "WAF"
    Project = var.project_label
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              echo "server {
                listen 80;
                location / {
                  proxy_pass http://${aws_instance.hello.private_ip};
                  proxy_set_header Host \$host;
                  proxy_set_header X-Real-IP \$remote_addr;
                  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
                  proxy_set_header X-Forwarded-Proto \$scheme;
                }
              }" > /etc/nginx/sites-available/default
              systemctl restart nginx
              EOF
}
