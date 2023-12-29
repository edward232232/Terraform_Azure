# Terraform Project

This project provides a straightforward Terraform script for rapidly deploying a virtual machine on Azure. It simplifies the process of setting up a Linux virtual machine and associating it with a public IP address. 

In addition to the basic setup, the script also leverages custom data to install Docker on the virtual machine during its initialization. This means that once the virtual machine is up and running, it's immediately ready for hosting Dockerized applications.

This project is all about getting your Dockerized applications up and running on a VM as quickly and effortlessly as possible.

## Project Structure

- `main.tf`: This is the main Terraform configuration file. It contains the definitions for the resources that will be created.
- `variables.tf`: This file contains the definitions for the variables used in `main.tf`.
- `linux-ssh.tpl`: This is a template file used by the `local-exec` provisioner in `main.tf` to generate a command for SSH access to the created virtual machine.
- `customdata.tpl`: This is a template file used to customize the virtual machine.
- `.terraform/`: This directory is created by Terraform to store its working files, including the plugins it downloads.
- `.terraform.lock.hcl`: This file is created by Terraform to lock the versions of the providers used in the project.
- `terraform.tfstate`: This is the state file created by Terraform to keep track of the resources it manages.
- `terraform.tfstate.backup`: This is a backup of the state file.


## Prerequisites

- Terraform installed
- Azure CLI installed and authenticated

## Usage

1. Clone the repository.
2. Navigate to the project directory.
3. Run `terraform init` to initialize the project.
4. Run `terraform plan` to see the changes that will be made.
5. Run `terraform apply` to apply the changes.

Please remember to replace the placeholders in the `variables.tf` file with your actual values.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request.

## License

This project is licensed under the MIT License.