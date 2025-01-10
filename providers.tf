terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.2"
    }
  }
}

provider "tfe" {
  alias    = "tfc"
  hostname = var.tfc_hostname
}
provider "azurerm" {
  subscription_id = var.subscription_id # This is not actually required for authorisation. However to run Terraform azurerm provider this is required. Please do not remove.
  features {}
}