terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}

provider "vsphere" {
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

module "vm" {
  source  = "git::https://ghe.coxautoinc.com/ETO-Autobahn/terraform-vsphere-vm.git?ref=v0.1.2" # If referencing GHE
  #source  = "tfelab.coxautoinc.com/cai/vm/vsphere"  # If referencing TFE Private Module Registry
  #version = "0.1.2"

  for_each = {for k, v in var.vsphere_vm_definition:  k => v}
    # vCenter Variables
    vsphere_datacenter = var.vsphere_datacenter
    vsphere_datastore  = var.vsphere_datastore
    vsphere_cluster    = var.vsphere_cluster
    vsphere_dvs        = var.vsphere_dvs
    vsphere_network    = var.vsphere_network

    # VM Variables
    vsphere_template      = var.vsphere_template

    vm_name     = each.value.vm_name
    num_cpus    = each.value.num_cpus
    memory      = each.value.memory
}