provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Project VPC"
  }
}

# Create Subnets
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.public_az

  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = var.private_az

  tags = {
    Name = "Private Subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main Internet Gateway"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Public Route Table"
  }
}

# Route to Internet Gateway
resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group for Web
resource "aws_security_group" "web" {
  vpc_id = aws_vpc.main.id
  name   = "web-sg"

  dynamic "ingress" {
    for_each = var.web_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Web Security Group"
  }
}

# Security Group for DB
resource "aws_security_group" "db" {
  vpc_id = aws_vpc.main.id
  name   = "db-sg"

  dynamic "ingress" {
    for_each = var.db_ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DB Security Group"
  }
}

# Web Instance
resource "aws_instance" "web" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]
  user_data            = file("server-script.sh")

  tags = {
    Name = "Web Server"
  }
}

# Elastic IP for Web Instance
resource "aws_eip" "web_eip" {
  instance = aws_instance.web.id
}

# DB Instance
resource "aws_instance" "db" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.private.id
  vpc_security_group_ids = [aws_security_group.db.id]

  tags = {
    Name = "DB Server"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "db_storage" {
  bucket_prefix = "db-storage-"

  tags = {
    Name = "DB S3 Bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "db_storage_block" {
  bucket                  = aws_s3_bucket.db_storage.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
