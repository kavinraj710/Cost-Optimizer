resource "aws_iam_role_policy" "lambda_policy" {
  name = "lambda_snapshot_policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeSnapshots",
          "ec2:DeleteSnapshot"
        ],
        Resource = "*"
      }
    ]
  })
}
