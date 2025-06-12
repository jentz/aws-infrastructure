variable "github_access_token" {
  description = "GitHub personal access token for repository access, only used for bootstrapping the Amplify app, should be removed after."
  default     = ""
  type        = string
  sensitive   = true
}
