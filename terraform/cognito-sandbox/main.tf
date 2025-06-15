provider "aws" {
  region = "eu-west-1"
}

import {
  to = aws_cognito_user_pool_domain.main
  id = "eu-west-1r7zfnvwv0"
}

resource "aws_cognito_user_pool_domain" "main" {
  certificate_arn       = null
  domain                = "eu-west-1r7zfnvwv0"
  managed_login_version = 2
  user_pool_id          = aws_cognito_user_pool.pool.id
}

#
import {
  to = aws_cognito_user_pool.pool
  id = "eu-west-1_R7Zfnvwv0"
}

resource "aws_cognito_user_pool" "pool" {
  alias_attributes           = ["email"]
  auto_verified_attributes   = ["email"]
  deletion_protection        = "ACTIVE"
  mfa_configuration          = "OFF"
  name                       = "User pool - d3t5g8"
  user_pool_tier             = "ESSENTIALS"
  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
    recovery_mechanism {
      name     = "verified_phone_number"
      priority = 2
    }
  }
  admin_create_user_config {
    allow_admin_create_user_only = false
  }
  email_configuration {
    configuration_set      = null
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = null
    reply_to_email_address = null
    source_arn             = null
  }
  password_policy {
    minimum_length                   = 8
    password_history_size            = 0
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true
    string_attribute_constraints {
      max_length = jsonencode(2048)
      min_length = jsonencode(0)
    }
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "family_name"
    required                 = true
    string_attribute_constraints {
      max_length = jsonencode(2048)
      min_length = jsonencode(0)
    }
  }
  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "given_name"
    required                 = true
    string_attribute_constraints {
      max_length = jsonencode(2048)
      min_length = jsonencode(0)
    }
  }
  sign_in_policy {
    allowed_first_auth_factors = ["PASSWORD"]
  }
  username_configuration {
    case_sensitive = false
  }
  verification_message_template {
    default_email_option  = "CONFIRM_WITH_CODE"
    email_message         = null
    email_message_by_link = null
    email_subject         = null
    email_subject_by_link = null
    sms_message           = null
  }
  
}

import {
  to = aws_cognito_user_pool_client.public_client
  id = "eu-west-1_R7Zfnvwv0/2uc1bc2vfstfp198uvq8shsepa"
}

import {
  to = aws_cognito_user_pool_client.confidential_client
  id = "eu-west-1_R7Zfnvwv0/39askr3efqggd2djrimgijpbcr"
}

resource "aws_cognito_user_pool_client" "public_client" {
  access_token_validity                         = 60
  allowed_oauth_flows                           = ["code"]
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_scopes                          = ["email", "openid", "phone"]
  auth_session_validity                         = 3
  callback_urls                                 = ["http://localhost:9555/callback", "https://d84l1y8p4kdic.cloudfront.net"]
  default_redirect_uri                          = null
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows                           = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret                               = null
  id_token_validity                             = 60
  logout_urls                                   = []
  name                                          = "My SPA app - ghz1nk"
  prevent_user_existence_errors                 = "ENABLED"
  read_attributes                               = []
  refresh_token_validity                        = 5
  supported_identity_providers                  = ["COGNITO"]
  user_pool_id                                  = aws_cognito_user_pool.pool.id
  write_attributes                              = []
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

resource "aws_cognito_user_pool_client" "confidential_client" {
  access_token_validity                         = 60
  allowed_oauth_flows                           = ["code"]
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_scopes                          = ["email", "openid", "phone", "profile"]
  auth_session_validity                         = 3
  callback_urls                                 = ["http://localhost:9555/callback", "https://d84l1y8p4kdic.cloudfront.net"]
  default_redirect_uri                          = null
  enable_propagate_additional_user_context_data = false
  enable_token_revocation                       = true
  explicit_auth_flows                           = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret                               = null
  id_token_validity                             = 60
  logout_urls                                   = []
  name                                          = "confidential auth code client"
  prevent_user_existence_errors                 = "ENABLED"
  read_attributes                               = []
  refresh_token_validity                        = 5
  supported_identity_providers                  = ["COGNITO"]
  user_pool_id                                  = aws_cognito_user_pool.pool.id
  write_attributes                              = []
  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}


