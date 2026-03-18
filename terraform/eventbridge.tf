resource "aws_cloudwatch_event_rule" "monthly" {
  name                = "snapshot-cleanup"
  schedule_expression = "cron(30 18 1 * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.monthly.name
  target_id = "lambda-target"
  arn  = aws_lambda_function.snapshot_cleaner.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
statement_id = "AllowEventBridge-${aws_cloudwatch_event_rule.monthly.name}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.snapshot_cleaner.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.monthly.arn
}
