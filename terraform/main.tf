provider "aws" {
  region = "eu-west-1"
}

# Use the default VPC
data "aws_vpc" "default" {
  default = true
}

# Get your current public IP automatically (optional)
# data "http" "myip" {
#   url = "https://checkip.amazonaws.com/"
# }

# Security Group allowing SSH only from your PC
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH from my PC only"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_ssh.id
  cidr_ipv4         = "197.32.190.2/32"  
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# EC2 Instance
resource "aws_instance" "demo" {
  ami           = "ami-00211ea7561f4b133" # Ubuntu AMI
  instance_type = "t2.micro"
  key_name      = "key-pair-nti-lab1"
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]  # <-- attach SG here

  tags = {
    Name = "jenkins-ec2"
  }
}

