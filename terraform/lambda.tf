locals {
  root = "${path.root}/${var.root_nesting}"
  build = "${local.root}/${var.build_dir}"
  zip = "${local.root}/${var.zipfile}"
}

resource "null_resource" "npm" {
  provisioner "local-exec" {
    working_dir = local.root
    command = "npm install && npm run ${var.npm}"
  }
  triggers = {
    rerun_every_time = uuid()
  }
}

data "archive_file" "lambda_source" {
  type = "zip"
  source_dir = local.build
  output_path = local.zip
  depends_on = [null_resource.npm]
}

resource "aws_lambda_function" "main" {
  function_name = local.full_name
  filename = local.zip
  source_code_hash = data.archive_file.lambda_source.output_base64sha256
  handler = var.handler
  runtime = var.runtime
  publish = var.publish
  role = aws_iam_role.lambda.arn
  depends_on = [
    aws_cloudwatch_log_group.lambda,
    data.archive_file.lambda_source
  ]
}
