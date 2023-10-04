
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket


terraform {
#     cloud {
#       organization = "nebly21"
#       workspaces {
#         name = "Terrahouse-1"
#       }
#   }
}


module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}