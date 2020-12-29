data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  name = "lambda-terraform-${var.stage}-${var.region}-lambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

locals {
  lambda_function_name = "${var.stage}-${var.name}"
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${local.lambda_function_name}"
}

// TODO RESTRICT THIS!
data "aws_iam_policy_document" "logs" {
  statement {
    effect = "Allow"
    actions = ["logs:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "logs" {
  name = "lambda-terraform-${var.stage}-cloudwatch-policy"
  policy = data.aws_iam_policy_document.logs.json
  role = aws_iam_role.lambda.id
}
