provider "aws" {
      region = "eu-west-2"
}

resource "aws_instance" "db" {
  ami = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"
}

resource "aws_instance" "web" {
  ami = "ami-0abb41dc69b6b6704"
  instance_type = "t2.micro"

 # this depends is make sure the instance db is created first then web instance 
 depends_on = [ aws_instance.db ]
}


# check the result when is the script is run

# Do you want to perform these actions?
#   Terraform will perform the actions described above.
#   Only 'yes' will be accepted to approve.

#   Enter a value: yes

# aws_instance.db: Creating... ( here create db instance first)
# aws_instance.db: Still creating... [10s elapsed]
# aws_instance.db: Creation complete after 13s [id=i-0ce0c11d693533839]
# aws_instance.web: Creating... ( creating web instance)
# aws_instance.web: Still creating... [10s elapsed]
# aws_instance.web: Creation complete after 12s [id=i-0b73ede31512dcc51]