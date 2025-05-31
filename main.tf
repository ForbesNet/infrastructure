terraform {
  required_providers {
    pihole = {
      source = "ryanwholey/pihole"
    }
  }

  backend "s3" {
    bucket = "forbesnet-tfstate"
    key    = "infrastructure"
    region = "us-east-1"
  }
}

provider "pihole" {
  url      = var.pihole_url
  password = var.pihole_admin_pass 
}

module "pihole_dns_record" {
  source = "./modules/pihole"
  for_each = var.pihole_dns_records

    dns_record = "${each.key}.forbesnet.local"
    ip = each.value.ip
}