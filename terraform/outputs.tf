output "lambda_iam_role" {
  value = aws_iam_role.lambda
}

output "endpoint" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}

output "build_path" {
  value = path.module
}

