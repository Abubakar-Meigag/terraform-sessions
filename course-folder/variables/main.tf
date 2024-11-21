variable "vpcname" {
  type    = string
  default = "terraform-vpc"
}

variable "ssport" {
  type    = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "mylist" {
  type    = list(string)
  default = ["value1", "value2"]
}

variable "mymap" {
  type = map(any)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "inputname" {
  type        = string
  description = "Set the name of the VPC"
}

resource "aws_vpc" "terraform-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}

output "vpcid" {
  value = aws_vpc.terraform-vpc.id
}

variable "mytuple" {
  type    = tuple([string, number, string])
  default = ["cat", 10, "dog"]
}

variable "myobject" {
  type = object({ name = string, port = list(number) })
  default = {
    name = "myobject"
    port = [80, 443]
  }
}




# how to set the name and used tags init
# resource "aws_vpc" "terraformVPC" {
#       cidr_block = "10.0.0.0/16"

#       tags = {
#         Name = var.vpcname
#         Name = var.mylist[0]
#         Name = var.mymap["key1"]
#         Name = var.inputname
#       }
# }
