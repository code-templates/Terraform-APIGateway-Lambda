resource "aws_lambda_function" "lambdaFunction" {
  function_name = "${local.serviceName}"
  description = "${local.DefaultDesc}"
	filename         = "../lambda-code/example.zip"
  source_code_hash = "${base64sha256(file("../lambda-code/example.zip"))}"
  handler = "main.handler"
  runtime = "nodejs10.x"
  role = "${aws_iam_role.lambda_exec.arn}"
  depends_on    = ["aws_iam_role_policy_attachment.lambda_logs", "aws_cloudwatch_log_group.lambdaLogGroup"]
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "${local.serviceName}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambdaFunction.arn}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_deployment.test.execution_arn}/*/*"
}