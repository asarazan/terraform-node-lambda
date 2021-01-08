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
  name = "${var.name}-${var.stage}-${var.region}-lambdaRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json
}

locals {
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${local.full_name}"
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
  name = "${var.name}-${var.stage}-${var.region}-policy"
  policy = data.aws_iam_policy_document.logs.json
  role = aws_iam_role.lambda.id
}
