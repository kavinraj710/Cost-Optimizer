resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/snapshot-cleaner"
  retention_in_days = 14
}
