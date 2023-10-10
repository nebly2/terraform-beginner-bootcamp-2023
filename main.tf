
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
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}