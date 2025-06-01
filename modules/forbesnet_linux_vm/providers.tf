terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.3.0"
    }
  }
}