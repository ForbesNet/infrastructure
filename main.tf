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


module "forbesnet_linux_vm" {
  source   = "./modules/forbesnet_linux_vm" # If referencing GHE
  for_each = var.linux_vms

    vm_name            = each.key
    num_cpus           = each.value.num_cpus
    memory             = each.value.memory
    ipv4_address       = each.value.ipv4_address
    vsphere_template   = each.value.vsphere_template
    vsphere_datacenter = each.value.vsphere_datacenter
    vsphere_datastore  = each.value.vsphere_datastore
    vsphere_cluster    = each.value.vsphere_cluster
    vsphere_network    = each.value.vsphere_network
}