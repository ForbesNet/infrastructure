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
  agent = {
    num_cpus           = 4
    memory             = 4
    ipv4_address       = "192.168.1.56"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  logstash = {
    num_cpus           = 4
    memory             = 4
    ipv4_address       = "192.168.1.57"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  k3s-master = {
    num_cpus           = 2
    memory             = 4
    ipv4_address       = "192.168.1.61"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  k3s-server0 = {
    num_cpus           = 2
    memory             = 4
    ipv4_address       = "192.168.1.62"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  k3s-server1 = {
    num_cpus           = 2
    memory             = 4
    ipv4_address       = "192.168.1.63"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },
  k3s-server2 = {
    num_cpus           = 2
    memory             = 4
    ipv4_address       = "192.168.1.64"
    vsphere_template   = "Packer/Packer_rocky9_5_LATEST"
    vsphere_datacenter = "Lab"
    vsphere_cluster    = "Cluster"
    vsphere_datastore  = "Datastore"
    vsphere_network    = "VM Network"
  },

}
