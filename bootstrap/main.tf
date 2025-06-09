provider "aws" {
  region = "eu-west-1"
}

module "terraform_state_s3" {
  source = "../modules/s3"
  name_prefix = "terraform-state"
  tags = {
    Project = "Bootstrap"
    Env = "admin"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Project = "Bootstrap"
    Env = "admin"
  }

}
