<<<<<<< HEAD
# elo-hub
=======
# Project Elo-V.0.1


## Table of Contents

- [Project Structure](#elo-project)

### Main Project Directory
.
|------- main.tf
|------- output.tf
|------- backend.tf
|------- rsa_key.pub
|------- rsa_key
|------- init_all.sh

### project/modules/vnet-hub/ Subdirectory
.
|------- main.tf
|------- outputs.tf
|------- variables.tf
|------- Other resources (e.g., script files, .tfvars files)

### project/modules/vnet-prd/ Subdirectory
.
|------- main.tf
|------- outputs.tf
|------- variables.tf
|------- Other resources

### project/modules/vnet-mgm/ Subdirectory
.
|------- main.tf
|------- outputs.tf
|------- variables.tf
|------- Other resources

## Project Structure

This Terraform project is organized as follows:

- *Main Files*:
  - main.tf: The root configuration file that uses various modules.
  - variables.tf: Defines the input variables used in the configuration.
  - outputs.tf: Contains output definitions for the resources created.

- *Modules*:
  - The modules directory contains three subfolders, each representing a separate module entity
  - Each module considired separated entity and its included in the root main.tf file and is named after the specific module

## Modules

the purpose and function of each module in the project

- Module 1: vnet-hub
--> Network key entry
- Module 2: vnet-prd
Aks cluster + Application Gateway to expose the application to the internet
- Module 3: vnet-mgm
Aks cluster + active directory for dev depatement

## Usage

this project structure can used with one state, but in order to target specific modules  in order to apply or dstroy you can use the following 

```bash
# Initialize Terraform (one-time setup)
terraform init   : /elo-project

# Apply the changes
terraform apply  : will init all modules in the main.tf thats means all vnet hub prd mgm will be affected

terraform apply -target=module.<module name> : it will affect just the module in question
>>>>>>> 55987c6 (first commint in project elo V.0.1)
>>>>>>> b43ca35 (Initial commit V.0.1)
