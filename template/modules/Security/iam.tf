# resource "aws_iam_role" "firehose_role" {
#   name = "firehose_role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [{
#     "Action": "sts:AssumeRole",
#     "Principal": {"Service": "firehose.amazonaws.com"},
#     "Effect": "Allow",
#     "Sid": ""
#   }]
# }
# EOF
# }

resource "aws_iam_role" "lambda_role" {
  name = "LambdaKinesisRole"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Action": "sts:AssumeRole",
    "Principal": {"Service": "lambda.amazonaws.com"},
    "Effect": "Allow",
    "Sid": ""
  }]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "LambdaKinesisPolicy"
  description = "Permite Lambda ler Kinesis e escrever no DynamoDB"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:PutItem"
      ],
      "Resource": "${var.dynamodb_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:GetRecords",
        "kinesis:GetShardIterator",
        "kinesis:DescribeStream",
        "kinesis:ListStreams"
      ],
      "Resource": "${var.kinesis_stream_arn}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
