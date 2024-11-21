provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "db" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    name = "DB server"
  }
}

resource "aws_instance" "web" {
  ami             = var.ami
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_traffic.name]
  user_data = file("server-script.sh")

  tags = {
    name = "web server"
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
}

resource "aws_security_group" "web_traffic" {
  name = "Allow Web Traffic"

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}

output "PublicIP" {
  value = aws_eip.web_ip.public_ip
}
