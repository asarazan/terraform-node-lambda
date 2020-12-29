output "lambda_iam_role" {
  value = aws_iam_role.lambda
}

output "endpoint" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}

output "lambda_console_url" {
  value = "https://console.aws.amazon.com/lambda/home?region=${var.region}#/functions/${local.full_name}"
}

output "build_path" {
  value = local.build
}

