# Terraform + Node + Lambda
A convenience module for deploying endpoints with AWS Lambda + API Gateway.

### TL;DR
It's fun to spin up APIs on lambda, and a great way to test out new features... but the terraform hackery required to do so is surprisingly heavy. This is a high-level module that will do the following:
1. Build & Zip your project
2. Deploy to Lambda
3. Provision API Gateway for proxy+root access with "ANY" method

See the example project for more details.

### Usage:
Just put this in your project's terraform module:
```tf
// We default to us-east-1. 
// If you use a different region, you will also want to pass it to the module.
provider "aws" {
  region = "us-east-1"
}

module "lambda" {
  source = "git@github.com:asarazan/terraform-node-lambda.git//terraform?ref=main"
  name = "lambda-example"
}

// These make it easy to open your newly created lambda, or invoke it via browser.
output "endpoint" {
  value = module.lambda.endpoint
}
output "lambda_console_url" {
  value = module.lambda.lambda_console_url
}
```

### TODO:
* Narrow the scope of logging in the IAM roles
* Come up with more flexible treatment of npm build configurations
* Figure a better way to invalidate/redeploy the api gateway coniguration.
