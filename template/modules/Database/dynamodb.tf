resource "aws_dynamodb_table" "workshop_events" {
  name = "workshop_events"
  billing_mode = "PROVISIONED"
  read_capacity = 1
  write_capacity = 1

  attribute {
    name = "event_id"
    type = "S"
  }

  hash_key = "event_id"
}