provider "aws" {
  region = "us-west-2"
}
locals {
  serviceName = "ServerlessRestAPI"
  DefaultDesc = "Managed by Terraform, Powered by https://github.com/code-templates/terraform-APIGateway-lambda"
}