resource "aws_lambda_function" "kinesis_processor" {
  function_name = "Kinesis-workshop"
  role          = var.lambda_arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  
  filename         = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  
  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_name
    }
  }
}