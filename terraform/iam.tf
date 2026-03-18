# IAM Role
resource "aws_iam_role" "lambda_role" {
  name = "lambda_snapshot_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# IAM Policy attached to Role
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
      },
{
  "Effect": "Allow",
  "Action": [
    "logs:CreateLogGroup",
    "logs:CreateLogStream",
    "logs:PutLogEvents",
    "logs:DeleteLogGroup",
    "logs:DescribeLogGroups"
  ],
  "Resource": "*"
}
    ]
  })
}
