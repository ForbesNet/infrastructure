linux_vms = {
  elastic = {
    num_cpus           = 4
    memory             = 8
    ipv4_address       = "192.168.1.59"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  fleet = {
    num_cpus           = 4
    memory             = 8
    ipv4_address       = "192.168.1.55"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
}
