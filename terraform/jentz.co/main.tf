provider "aws" {
  region = "eu-west-1"
}

module "jentz_co_amplify" {
  source = "../modules/amplify"

  app_name       = "jentz-co"
  repository_url = "https://github.com/jentz/jentz.co"

  github_access_token = var.github_access_token

  domain_name          = "jentz.co"
  enable_www_subdomain = true
  main_branch_name     = "main" # Change this if your main branch has a different name

  hugo_version = "0.147.8" # Update to your Hugo version

  environment_variables = {
    # Add any environment variables your Hugo site needs
    # HUGO_ENV = "production"
  }

  tags = {
    Project = "jentz.co"
    Env     = "prod"
  }
}
