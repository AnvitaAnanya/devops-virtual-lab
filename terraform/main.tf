provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "devops_ssh" {
  name        = "devops-lab-ssh"
  description = "Allow SSH access for DevOps lab"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps-Lab-SSH"
  }
}

resource "aws_instance" "devops_server" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t2.micro"
  key_name               = "my-key"
  vpc_security_group_ids = [aws_security_group.devops_ssh.id]

  tags = {
    Name = "DevOps-Lab-Server"
  }
}
