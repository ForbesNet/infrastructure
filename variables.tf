variable "pihole_url" {
    description = "URL of pihole server"
    type = string
    default = "http://pi.hole"
}

variable "pihole_admin_pass" {
    description = "pihole admin pass...duh"
    type = string
    default = ""
}

variable "pihole_dns_records" {
    type = map(object({
        #dns_record = string
        ip = string
    }))
}


## Target vSphere Instance Information ##
# The values of these variables should be passed using either environment vars or set in TFE directly
variable "vsphere_user" {
  description = "UPN of the user for which the connection and commands will run as"
  type        = string
  default     = ""
}

variable "vsphere_password" {
  description = "Password of the user for which the connection and commands will run as"
  type        = string
  default     = ""
  sensitive   = true
}

variable "vsphere_server" {
  description = "Target vCenter server where the infrastructure data will be pulled and the VM will be built"
  type        = string
  default     = ""
}

# ## vSphere Infrastructure Information ##
# variable "vsphere_datacenter" {
#   description = "Target datacenter within vCenter where the VM will be placed"
#   type        = string
#   default     = ""
# }

# variable "vsphere_datastore" {
#   description = "Target datastore within vCenter where the VM will be placed"
#   type        = string
#   default     = ""
# }

# variable "vsphere_cluster" {
#   description = "Target cluster within vCenter where the VM will be placed"
#   type        = string
#   default     = ""
# }

# variable "vsphere_dvs" {
#   description = "Target distributed virtual switch within vCenter that hosts the VM's network"
#   type        = string
#   default     = ""
# }

# variable "vsphere_network" {
#   description = "Target network within vCenter where the VM will be placed"
#   type        = string
#   default     = ""
# }

# variable "vsphere_template" {
#   description = "The vSphere OS template that will be used to deploy the VM"
#   type        = string
#   default     = ""
# }

## Virtual Machine Information ##
variable "linux_vms" {
  type = map(object({
    num_cpus           = number
    memory             = number
    ipv4_address       = string
    vsphere_template   = string
    vsphere_datacenter = string
    vsphere_cluster    = string
    vsphere_datastore  = string
    vsphere_network    = string
  }))
}