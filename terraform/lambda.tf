resource "aws_lambda_function" "snapshot_cleaner" {
  function_name = "snapshot-cleaner"

  filename         = "../lambda.zip"
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
  role             = aws_iam_role.lambda_role.arn

  timeout = 30
}