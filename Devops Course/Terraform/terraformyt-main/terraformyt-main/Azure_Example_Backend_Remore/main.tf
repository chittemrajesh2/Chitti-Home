# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "tfstate"
      storage_account_name = "<storage_account_name>"
      container_name       = "tfstate"
      key                  = "terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "state-demo-secure" {
  name     = "state-demo"
  location = "eastus"
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret
provider "azurerm" {
  features {} 
  client_id       = "00000000-0000-0000-0000-000000000000"
  client_secret   = "20000000-0000-0000-0000-000000000000"
  tenant_id       = "10000000-0000-0000-0000-000000000000"
  subscription_id = "20000000-0000-0000-0000-000000000000"
}

#create resource group
resource "azurerm_resource_group" "rg" {
    name     = "${var.rgname}"
    location = "${var.location}"
    tags      = {
        Environment = "Terraform Demo"
    }
}
