output "dynamodb_arn" {
  value = aws_dynamodb_table.workshop_events.arn
}

output "dynamodb_name" {
  value = aws_dynamodb_table.workshop_events.name
}