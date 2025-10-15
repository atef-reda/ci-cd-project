provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-00211ea7561f4b133" #  Ubuntu AMI
  instance_type = "t2.micro"
  key_name      = "key-pair-nti-lab1"
  tags = {
    Name = "jenkins-ec2"
  }
}

