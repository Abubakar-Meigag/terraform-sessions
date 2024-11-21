terraform {
  backend "s3" {
      key = "terraform/tfstate.tfstate"
      bucket = "unique-bucket-name" # add-here-the-bucket-name-you-create-it-in-s3
      region = "eu-west-2"
      access_key = ""  # you could leave this blank and it pop up in terminal then add it there 
      secret_key = ""  # you could leave this blank and it pop up in terminal then add it there 
      # cat ~/.aws/credentials 
  }
}


# here is hot to save your tfstate file into s3 bucket