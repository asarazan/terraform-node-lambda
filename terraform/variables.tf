/**
 * Not currently configurable: things will get spun up as e.g. `my-project-dev`
 */
locals {
  full_name = "${var.name}-${var.stage}"
}

/**
 * We assume that your terraform files are in e.g. `{root}/terraform` so we pop one directory to get at project.
 */
variable "root_nesting" {
  default = ".."
}

/**
 * e.g. my-project or best-dogs or something I don't know.
 */
variable "name" {
  description = "The basename for the Lambda function and most associated resources."
}

/**
 * Refer to AWS Lambda docs for supported node versions.
 */
variable "runtime" {
  default = "nodejs12.x"
}

/**
 * Starter projects will accept any http method. Feel free to change that here.
 */
variable "method" {
  default = "ANY"
}

/**
 * We assume your built files live in `{root}/lib`
 */
variable "build_dir" {
  default = "lib"
}

/**
 * AWS lambda handler path
 */
variable "handler" {
  default = "index.handler"
}

/**
 * We call `npm run {x}` to build your project.
 */
variable "buildscript" {
  default = "build"
}

/**
 * We assume your zipfile gets placed at `{root}/lambda.zip`
 */
variable "zipfile" {
  default = "lambda.zip"
}

/**
 * So you can feel the thrill of going down at the same time as netflix.
 */
variable "region" {
  default = "us-east-1"
}

/**
 * You'll get to prod one day little buddy.
 */
variable "stage" {
  default = "dev"
}