locals {
  developers_inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:StartSession"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ssm:*:*:session/$$${aws:username}-*"
      },
      {
        Action = [
          "ssm:TerminateSession",
          "ssm:ResumeSession"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  database_inline_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds:*",
          "dynamodb:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ssm:StartSession"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:ssm:*:*:session/$$${aws:username}-*"
      },
      {
        Action = [
          "ssm:TerminateSession",
          "ssm:ResumeSession"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "cloudwatch:Describe*",
          "cloudwatch:Get*",
          "cloudwatch:List*"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
