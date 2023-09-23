terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
}

provider "random" {
  # Configuration options
}
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket

resource "random_string" "bucket_name" {
  # Bucket Naming rules
  # https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console
  length = 32
  special = false
  lower = true
  upper = false
}


resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result
  }


output "random_bucket_name" {
  value = random_string.bucket_name.result
}
