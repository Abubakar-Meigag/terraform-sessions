variable "server_names" {
  type = list(string)
}

resource "aws_instance" "db" {
  ami           = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"
  count         = length(var.server_names)

  tags = {
    name = var.server_names[count.index]
  }
}

output "PrivateIP" {
  value = [aws_instance.db.*.private_ip]
}