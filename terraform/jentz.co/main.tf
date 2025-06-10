provider "aws" {
  region = "eu-west-1"
}

module "jentz_co_s3" {
  source         = "../modules/s3-static-website"
  name_prefix    = "jentz-co"
  index_document = "index.html"
  error_document = "404.html"
  tags = {
    Project = "jentz.co"
    Env     = "prod"
  }
}

