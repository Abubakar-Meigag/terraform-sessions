variable "ec2name" {
  type = string
}

resource "aws_instance" "ec2" {
  ami = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"

  tags = {
    name = "ec2name"
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}
