
# terraform-vsphere-vm
## About This Module
This module will deploy one or multiple simple vSphere virtual machine(s) from an OS-based vSphere template. A custom spec will NOT be applied as part of this deployment (there is a separate module for this type of deployment).

## Pre-requisites
This module is intended to run with minimal preparation, however it does have the following pre-requisites:
1. Desired specifications of the new machine(s), including a hostname, the OS template to use, and machine sizing.

2. Credentials to the target vCenter where the machine(s) will be deployed, with enough permission to deploy a virtual machine in the target infrastructure.

## How to Use This Module
1. Ensure desired server specs are in hand and the vSphere account meets the module pre-requisites from above.

2. From the `examples/` directory, copy the contents of the sample `terraform.auto.tfvars` file from the folder representing your desired implementation type to the `.auto.tfvars` file in your configuration. Update the variable values accordingly.

3. While still within the `examples/ ` directory, copy the contents of the `variables.tf` file to the `variables.tf` file in your configuration.

4. Add the following provider information to your root configuration (providers should be placed here, rather than in the module itself):
```hcl
terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }
}

provider "vsphere" {
  # If you have a self-signed cert, set to true
  allow_unverified_ssl = true
}
```

5. **For single VM deployments**: Add the following logic into your Terraform configuration's `main.tf` to make the module call and pass the required inputs. Be sure to update module version as appropriate.

```hcl
module "vm" {
  # Alternatively, point to GHE for testing outside of TFE
  source  = "tfelab.coxautoinc.com/cai/vm/vsphere" 
  version = "0.1.0"

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
  disk_label  = var.vsphere_vm_definition.disk_label
}
```
**For multi-machine deployments**: Add the following logic into your Terraform configuration's `main.tf` to make the module call and pass the required inputs. Be sure to upate module version as appropriate.
```hcl
module "vm" {
  # Alternatively, point to GHE for testing outside of TFE (see below)
  source  = "tfelab.coxautoinc.com/cai/vm/vsphere"   
  version = "0.1.0"
  
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
    disk_label  = each.value.disk_label
}
```
*Using GHE Instead of Private Module Registry*
If doing local testing and you just want to pull from the repo directly, you can use the following entry (with updated module version) in place of the source/version values within the module call:
'source  = "git::https://ghe.coxautoinc.com/ETO-Autobahn/terraform-vsphere-vm.git?ref=v0.0.6"`

*Handling Credentials*
You will need a valid hostname/IP, username, and password to a VMware vCenter instance to execute. However, passing credentials as static values within your configuration will save these sensitive values in plain text to state, which should be avoided where ever possible. To prevent this, pass these details as *environment variables* instead.vSphere has its own special ones, as noted below.

To pass credential information for GENERIC variables (i.e. manually created) - for example:  ssh_password - use the following format: `export TF_VAR_ssh_password="test$$h12345!"`.

When deploying to TFE, vCenter credential information may also be stored in the *environment variables* section of the TFE Workspace's variables with "sensitive" selected to redact from automated outputs. This way, TFE encrypts the state file and access to the file can be controlled. Additionally, variable entries placed here are stored in the integrated Vault instance.

If executing from the CLI to TFE, you will also need to login to TFE. Use `terraform login` or a local `terraform.rc` (or `.terraformrc`, depending on OS) file with needed credential block to pass a pre-created user token from TFE. [Click here for more details.](https://www.terraform.io/docs/cli/config/config-file.html)

6. Pass the required environment variables for the target vSphere environment:
    ```
    export VSPHERE_USER="first.last@domain.com"
    export VSPHERE_PASSWORD="myGr3@T!P@$$w0rd!!!"
    export VSPHERE_SERVER="vc-srv.domain.com"
    ``` 

7. Install the modules and provider plugins:
    ```
    terraform init
    ```
8. Create an execution plan:
    ```
    terraform plan
    ```
9. Apply (and approve) the changes:
    ```
    terraform apply
    ```

## Sampling This Module
The `examples/` directory contains Terraform code samples that demonstrate how to consume the module and the variables required. You will need a valid hostname/IP, username, and password to a VMware vCenter instance to execute the example.

*Please see section above: Handling Credentials*

1. Navigate to `examples/` to make it your current directory.

2. Update the `terraform.auto.tfvars` file with your example values.

3. Pass the required environment variables for the target vSphere environment:
    ```
    export VSPHERE_USER="first.last@domain.com"
    export VSPHERE_PASSWORD="myGr3@T!P@$$w0rd!!!"
    export VSPHERE_SERVER="vc-srv.domain.com"
    ``` 

4. Install the modules and provider plugins:
    ```
    terraform init
    ```
5. Create an execution plan:
    ```
    terraform plan
    ```
6. Apply (and approve) the changes:
    ```
    terraform apply
    ```

### Required Inputs
#### Pass as Environment Variables:
`vsphere_user`       = UPN of vCenter account with access to deploy a VM in the target vCenter/infrastructure

`vsphere_password`   = Password of the vCenter account being used

`vsphere_server`     = Target vCenter where the VM will be deployed

#### vSphere and Virtual Machine Variables:
`vsphere_datacenter` = vSphere datacenter where VM will be deployed

`vsphere_datastore`  = vSphere datastore where VM will be deployed

`vsphere_cluster`    = vSphere cluster where VM will be deployed

`vsphere_dvs`        = vSphere distributed virtual network where VM will be deployed

`vsphere_network`    = vSphere network where VM will be deployed

`vsphere_template`   = vSphere OS-based template that will be used to deploy the VM

`vsphere_vm_definition` => The attributes below define the VM object: 

  `vm_name`    = Name of the virtual machine being created

  `num_cpus`   = Number of vCPUs to assign to the VM

  `memory`     = Amount of memory (GB) to assign to the VM

  `disk_label` = Disk label to assign to the VM's storage drive
