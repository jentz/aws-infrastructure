output "amplify_app_id" {
  description = "ID of the Amplify app"
  value       = module.jentz_co_amplify.app_id
}

output "amplify_default_domain" {
  description = "Default domain for the Amplify app"
  value       = module.jentz_co_amplify.app_default_domain
}

output "amplify_production_branch" {
  description = "Production branch name"
  value       = module.jentz_co_amplify.app_production_branch
}
