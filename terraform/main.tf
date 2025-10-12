provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "demo" {
  ami           = "ami-0c55b159cbfafe1f0" # Example Ubuntu AMI
  instance_type = "t2.micro"
  key_name      = "key-pair-nti-lab1"
  tags = {
    Name = "jenkins-ec2"
  }
}

output "instance_ip" {
  value = aws_instance.demo.public_ip
}

