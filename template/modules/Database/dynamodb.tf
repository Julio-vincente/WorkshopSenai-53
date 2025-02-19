resource "aws_dynamodb_table" "workshop_events" {
  name = "workshop_events"

  attribute {
    name = "event_id"
    type = "S"
  }

  hash_key = "event_id"
}