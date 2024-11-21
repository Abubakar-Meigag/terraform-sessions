resource "aws_instance" "db" {
  ami           = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"

  tags = {
    name = "DB server"
  }
}

output "PrivateIP" {
  value = aws_instance.db.private_ip
}