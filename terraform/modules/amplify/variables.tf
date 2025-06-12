variable "app_name" {
  description = "Name of the Amplify app"
  type        = string
}

variable "repository_url" {
  description = "URL of the GitHub repository"
  type        = string
}

variable "github_access_token" {
  description = "GitHub personal access token for repository access"
  type        = string
  sensitive   = true
}

variable "domain_name" {
  description = "Domain name to associate with the Amplify app"
  type        = string
}

variable "main_branch_name" {
  description = "Name of the main branch to deploy"
  type        = string
  default     = "main"
}

variable "hugo_version" {
  description = "Hugo version to use for building the site"
  type        = string
  default     = "0.147.8"
}

variable "enable_www_subdomain" {
  description = "Whether to enable www subdomain redirect"
  type        = bool
  default     = true
}

variable "environment_variables" {
  description = "Environment variables for the Amplify app"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "auto_branch_creation_patterns" {
  description = "Patterns for auto branch creation in Amplify app"
  type        = list(string)
  default = [
    "*",
    "*/**",
  ]
}
