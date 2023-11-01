terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
   organization = "nebly21"
   workspaces {
     name = "Terrahouse-1"
   }
  }

}
// 2ff43ed9-3759-4dd6-978b-e6de3cc3d48a
provider "terratowns" {
  endpoint = "https://terratowns.cloud/api"
  user_uuid=var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "terrahouse_aws" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.teacherseat_user_uuid
 index_html_filepath = var.index_html_filepath
 error_html_filepath = var.error_html_filepath
 content_version = var.content_version
 assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "What team compositions to play in Teamfight Tactics (set 9.5)"
  description = <<DESCRIPTION
  Teamfight Tactics (TFT) is an auto-battler game mode within the popular multiplayer online battle arena (MOBA) game League of Legends, developed by Riot Games. In TFT, players assemble teams of champions and pit them against each other in automated battles. This guide will show you the team compositions that are the strongest in set 9.5.
DESCRIPTION
  # domain_name = "dffs2gsh.cloudfront.net"
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}