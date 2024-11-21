output "web_public_ip" {
  description = "Public IP of the web server"
  value       = aws_eip.web_eip.public_ip
}

output "db_private_ip" {
  description = "Private IP of the database server"
  value       = aws_instance.db.private_ip
}

output "s3_bucket_name" {
  description = "Name of the created S3 bucket"
  value       = aws_s3_bucket.db_storage.id
}

