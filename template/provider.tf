provider "aws" {
  region = var.aws_region
}

module "Database" {
  source = "./modules/Database"
}

module "Iam" {
  source             = "./modules/Security"
  dynamodb_arn       = module.Database.dynamodb_arn
  kinesis_stream_arn = module.Streaming.kinesis_stream_arn

}


module "Function" {
  source        = "./modules/Function"
  dynamodb_name = module.Database.dynamodb_name
  lambda_arn    = module.Iam.lambda_arn
}

module "Streaming" {
  source       = "./modules/Streaming"
}
