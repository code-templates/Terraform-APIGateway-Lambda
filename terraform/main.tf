provider "aws" {
  region = "us-west-2"
}
locals {
  serviceName = "ServerlessRestAPI"
  DefaultDesc = "Managed by Terraform"
}