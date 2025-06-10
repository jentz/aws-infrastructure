output "bucket_name" {
  description = "The name of the S3 bucket."
  value       = aws_s3_bucket.this.bucket
}

output "website_endpoint" {
  description = "The website endpoint of the S3 bucket."
  value       = aws_s3_bucket_website_configuration.this.website_endpoint
}

output "website_domain" {
  description = "The website domain of the S3 bucket."
  value       = aws_s3_bucket_website_configuration.this.website_domain
}
