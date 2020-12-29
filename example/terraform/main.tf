provider "aws" {
  region = "us-east-1"
}

module "lambda" {
  source = "git@github.com:asarazan/terraform-node-lambda.git//terraform?ref=main"
  name = "lambda-example"
}

output "endpoint" {
  value = module.lambda.endpoint
}