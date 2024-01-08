# Terraform Scripts

This project is a collection of Terraform scripts that I use for quick deployment of Azure Resources. This include creating a Linux virtual machine, associating it with a public IP address, and installing Docker on the virtual machine during its initialization. This means that the virtual machine is not only provisioned but also prepared with a Docker environment, ready to host Dockerized applications as soon as it's up and running.



This project is all about enabling quick and effortless deployment of Dockerized applications on Azure, either within a virtual machine or as standalone containers, using the Terraform scripts that I have developed and used over time.

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
