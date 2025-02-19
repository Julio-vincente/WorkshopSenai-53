resource "aws_kinesis_stream" "kds" {
    name = "Ingestion-Workshop"
    shard_count = 1
    retention_period = 24

    stream_mode_details {
        stream_mode = "ON_DEMAND"
    }
  
}

resource "aws_s3_bucket" "firehose_bucket" {
    bucket = "game-ingestion-firehose-data"
}

resource "aws_kinesis_firehose_delivery_stream" "firehose" {
  name        = "Workshop-Firehose"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = var.firehose_arn
    bucket_arn = aws_s3_bucket.firehose_bucket.arn
  }
}