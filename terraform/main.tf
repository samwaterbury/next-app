terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_cognito_user_pool" "user_pool" {
  alias_attributes         = ["email"]
  auto_verified_attributes = ["email"]
  name                     = "next-app"

  account_recovery_setting {
    recovery_mechanism {
      name     = "verified_email"
      priority = 1
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = 2048
      min_length = 0
    }
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "name"
    required                 = true

    string_attribute_constraints {
      max_length = 2048
      min_length = 0
    }
  }

  username_configuration {
    case_sensitive = true
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  access_token_validity                = 60
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid", "profile"]
  callback_urls                        = ["http://localhost:3000/api/auth/callback/cognito"]
  explicit_auth_flows                  = ["ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
  generate_secret                      = true
  id_token_validity                    = 60
  name                                 = aws_cognito_user_pool.user_pool.name
  supported_identity_providers         = ["COGNITO"]
  user_pool_id                         = aws_cognito_user_pool.user_pool.id

  token_validity_units {
    access_token  = "minutes"
    id_token      = "minutes"
    refresh_token = "days"
  }
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = aws_cognito_user_pool.user_pool.name
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
