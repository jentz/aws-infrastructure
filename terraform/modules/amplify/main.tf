resource "aws_amplify_app" "this" {
  name         = var.app_name
  repository   = var.repository_url
  access_token = var.github_access_token

  # Hugo build settings
  build_spec = <<-EOT
    version: 1
    frontend:
      phases:
        preBuild:
          commands:
            - curl -L -o hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${var.hugo_version}/hugo_extended_${var.hugo_version}_Linux-64bit.tar.gz
            - tar -xzf hugo.tar.gz
            - chmod +x hugo
        build:
          commands:
            - ./hugo --minify
      artifacts:
        baseDirectory: public
        files:
          - '**/*'
      cache:
        paths: []
  EOT

  # Auto build code when new commits are pushed
  enable_auto_branch_creation = true
  enable_branch_auto_build    = true

  auto_branch_creation_patterns = var.auto_branch_creation_patterns

  # Environment variables
  environment_variables = var.environment_variables

  tags = var.tags
}

# Set up the main branch
resource "aws_amplify_branch" "main" {
  app_id      = aws_amplify_app.this.id
  branch_name = var.main_branch_name

  framework = "Hugo"
  stage     = "PRODUCTION"

  tags = var.tags
}

# Domain association
resource "aws_amplify_domain_association" "this" {
  app_id      = aws_amplify_app.this.id
  domain_name = var.domain_name

  # Set up the main domain (jentz.co)
  sub_domain {
    branch_name = aws_amplify_branch.main.branch_name
    prefix      = ""
  }

  # Set up www subdomain if needed
  dynamic "sub_domain" {
    for_each = var.enable_www_subdomain ? [1] : []
    content {
      branch_name = aws_amplify_branch.main.branch_name
      prefix      = "www"
    }
  }
}
