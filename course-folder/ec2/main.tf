provider "aws" {
      region = "eu-west-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"
}