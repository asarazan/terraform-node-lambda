provider "aws" {
  region = "us-east-1"
}

module "lambda" {
  source = "../../terraform"
//  source = "git@github.com:asarazan/terraform-node-lambda.git//terraform?ref=main"
  name = "lambda-example"
}

output "endpoint" {
  value = module.lambda.endpoint
}

output "lambda_console_url" {
  value = module.lambda.lambda_console_url
}