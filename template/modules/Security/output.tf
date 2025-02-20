# output "firehose_arn" {
#     value = aws_iam_role.firehose_role.arn
# }

output "lambda_arn" {
  value = aws_iam_role.lambda_role.arn
}