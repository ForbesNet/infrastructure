# vSphere provider should be added to the root configuration

# Create the vSphere virtual machine
resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = var.num_cpus
  memory   = var.memory * 1024
  guest_id = data.vsphere_virtual_machine.template.guest_id
  scsi_type = data.vsphere_virtual_machine.template.scsi_type
  #guest_id         = "fedora64Guest"

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    timeout       = 60
  }

  lifecycle {
    ignore_changes = [
      clone.0.template_uuid
    ]
  }
  provisioner "local-exec" {
    #command = "ansible-playbook ip_vm.yml --extra-vars "vm_name=${var.vm_name} ipv4_address={var.ipv4_address}" -u packer -p 'packer'"
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u packer -p 'packer' -e 'vm_name=${var.vm_name}' -e 'ipv4_address=${var.ipv4_address}' ip_vm.yml"
  }

}

