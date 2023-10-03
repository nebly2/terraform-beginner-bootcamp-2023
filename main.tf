
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
  tags = {
    UserUuid = var.user_uuid
  }
}




