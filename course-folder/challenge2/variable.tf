variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

variable "egress" {
  type    = list(number)
  default = [80, 443]
}

variable "ami" {
  type        = string
  default     = "ami-0abb41dc69b6b6704"
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type for the EC2 instance"
}
