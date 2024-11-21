variable "ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0abb41dc69b6b6704"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}