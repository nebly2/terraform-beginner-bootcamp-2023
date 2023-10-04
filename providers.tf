terraform {
#     cloud {
#       organization = "nebly21"
#       workspaces {
#         name = "Terrahouse-1"
#       }
#   }
  required_providers {
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