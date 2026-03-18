resource "aws_cloudwatch_event_rule" "monthly" {
  name                = "snapshot-cleanup"
  schedule_expression = "cron(30 18 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.monthly.name
  arn  = aws_lambda_function.snapshot_cleaner.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_cleaner.function_name
  principal     = "events.amazonaws.com"
}