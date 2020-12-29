resource "aws_api_gateway_rest_api" "lambda" {
  name = local.full_name
  tags = {
    STAGE = var.stage
  }
}

resource "aws_lambda_permission" "api" {
  function_name = local.full_name
  principal = "apigateway.amazonaws.com"
  action = "lambda:InvokeFunction"
  source_arn = "${aws_api_gateway_rest_api.lambda.execution_arn}/*/*"
  depends_on = [aws_lambda_function.main]
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  parent_id   = aws_api_gateway_rest_api.lambda.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = aws_api_gateway_rest_api.lambda.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = var.method
  authorization = "NONE"
}

resource "aws_api_gateway_method" "root" {
  rest_api_id   = aws_api_gateway_rest_api.lambda.id
  resource_id   = aws_api_gateway_rest_api.lambda.root_resource_id
  http_method   = var.method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxy.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.main.invoke_arn
}

resource "aws_api_gateway_integration" "root" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  resource_id = aws_api_gateway_rest_api.lambda.root_resource_id
  http_method = aws_api_gateway_method.root.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.main.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  rest_api_id = aws_api_gateway_rest_api.lambda.id
  stage_name = var.stage
  depends_on = [aws_api_gateway_integration.proxy]
  // TODO find way to signal recreation of deployment
//  stage_description = md5(file("gateway.tf"))
}
