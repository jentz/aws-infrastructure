output "app_id" {
  description = "ID of the Amplify app"
  value       = aws_amplify_app.this.id
}

output "app_default_domain" {
  description = "Default domain for the Amplify app"
  value       = aws_amplify_app.this.default_domain
}

output "app_production_branch" {
  description = "Production branch name"
  value       = aws_amplify_branch.main.branch_name
}

output "app_arn" {
  description = "ARN of the Amplify app"
  value       = aws_amplify_app.this.arn
}

output "domain_association_id" {
  description = "ID of the domain association"
  value       = aws_amplify_domain_association.this.id
}
