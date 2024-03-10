# terraform {
#   backend "s3" {
#     bucket         = "primuslearning-terraform-state"
#     dynamodb_table = "primuslearning-terraform-state-dynamodb"
#     key            = "jenkins/terraform.tfstate"
#     region         = "us-east-1"
#   }
# }