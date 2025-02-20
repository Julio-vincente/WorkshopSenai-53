resource "aws_lambda_function" "kinesis_processor" {
  function_name = "Kinesis-workshop"
  role          = var.lambda_arn
  runtime       = "python3.9"
  handler       = "lambda_function.lambda_handler"
  timeout       = 60
  
  filename         = "modules/Function/lambda_function.zip"
  source_code_hash = filebase64sha256("modules/Function/lambda_function.zip")
  
  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_name
    }
  }
}

## task 2 