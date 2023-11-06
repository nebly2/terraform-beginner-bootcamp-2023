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

# module "home_tft_hosting" {
#  source = "./modules/terrahome_aws"
#  user_uuid = var.teacherseat_user_uuid
#  public_path = var.tft.public_path
#  content_version = var.tft.content_version
# }

module "home_brownies_hosting" {
 source = "./modules/terrahome_aws"
 user_uuid = var.teacherseat_user_uuid
 public_path = var.brownies.public_path
 content_version = var.brownies.content_version
}

# resource "terratowns_home" "home_TFT" {
#   name = "What team compositions to play in Teamfight Tactics (set 9.5)"
#   description = <<DESCRIPTION
#   Teamfight Tactics (TFT) is an auto-battler game mode within the popular multiplayer online battle arena (MOBA) game League of Legends, developed by Riot Games. In TFT, players assemble teams of champions and pit them against each other in automated battles. This guide will show you the team compositions that are the strongest in set 9.5.
# DESCRIPTION
#   # domain_name = "dffs2gsh.cloudfront.net"
#   domain_name = module.home_tft_hosting.domain_name
#   town = "missingo"
#   content_version = var.tft.content_version
# }

resource "terratowns_home" "home_brownies" {
  name = "Brownie recipe"
  description = <<DESCRIPTION
  How to make brownies
DESCRIPTION
  # domain_name = "dffs2gsh.cloudfront.net"
  domain_name = module.home_brownies_hosting.domain_name
  town = "cooker-cove"
  content_version = var.brownies.content_version
}