provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "myRDS" {
      db_name                 = "myDB"
      identifier              = "my-first-rds"
      instance_class          = "db.t2.micro"
      engine                  = "mariadb"
      engine_version          = "10.2.21"
      username                = "bob"
      password                = "mySecurePassword" # not recommended ( not best practice )
      port                    = 3306
      allocated_storage       = 20
      storage_type            = "gp2"
      skip_final_snapshot     = true
}