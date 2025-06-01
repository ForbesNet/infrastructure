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
  source  = "../terraform-vsphere-vm"  # If referencing GHE
  #source  = "tfelab.coxautoinc.com/cai/vm/vsphere"  # If referencing TFE Private Module Registry
  #version = "0.1.2"

  # vCenter Variables
  vsphere_datacenter = var.vsphere_datacenter
  vsphere_datastore  = var.vsphere_datastore
  vsphere_cluster    = var.vsphere_cluster
  vsphere_dvs        = var.vsphere_dvs
  vsphere_network    = var.vsphere_network

  # VM Variables
  vsphere_template      = var.vsphere_template

  vm_name     = var.vsphere_vm_definition.vm_name
  num_cpus    = var.vsphere_vm_definition.num_cpus
  memory      = var.vsphere_vm_definition.memory
}