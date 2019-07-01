# Terraform-APIGateway-Lambda
A demo to set up APIGateway &amp; Lambda by Terraform

## Usage

- Clone Code:

```
git clone git@github.com:code-templates/Terraform-APIGateway-Lambda.git
```

- Package the NodeJS code to zip:

```
cd lambda-code
zip example.zip main.js
```

- Set up Lambda & API-gateway

```
export AWS_ACCESS_KEY_ID=xxxxx
export AWS_SECRET_ACCESS_KEY=xxxxx
cd terraform apply
terraform apply
```
