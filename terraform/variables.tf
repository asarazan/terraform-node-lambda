locals {
  full_name = "${var.name}-${var.stage}"
}

variable "root_nesting" {
  default = ".."
}

variable "name" {
  description = "The basename for the Lambda function and most associated resources."
}

variable "runtime" {
  default = "nodejs12.x"
}

variable "publish" {
  default = "true"
}

variable "method" {
  default = "ANY"
}

variable "build_dir" {
  default = "lib"
}

variable "path" {
  default = "{proxy+}"
}

variable "handler" {
  default = "index.handler"
}

variable "npm" {
  default = "build"
}

variable "zipfile" {
  default = "lambda.zip"
}

variable "region" {
  default = "us-east-1"
}

variable "stage" {
  default = "dev"
}