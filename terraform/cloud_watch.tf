resource "aws_lambda_permission" "allowCloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambdaFunction.arn}"
  principal     = "logs.us-west-2.amazonaws.com"
}

resource "aws_cloudwatch_log_group" "lambdaLogGroup" {
  name              = "/aws/lambda/${local.serviceName}"
  retention_in_days = 14
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambdaLoggingPolicy" {
  name = "lambdaLoggingPolicy"
  path = "/"
  description = "${local.DefaultDesc}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${aws_iam_policy.lambdaLoggingPolicy.arn}"
}
