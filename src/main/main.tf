
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "myTFResourceGroup"
  location = "westus2"
}

module "storageaccount" {
  source = "../modules/storage/account"

  location = azurerm_resource_group.rg.location
  rg_name = azurerm_resource_group.rg.name
  account_name = "tfstatus"

}

module "storagecontainer" {
  source = "../modules/storage/container"

  storage_account_name = module.storageaccount.sa_name
  container_name = "tfcontainer"

}

module "storageblob" {
  source = "../modules/storage/blob"

  storage_account_name = module.storageaccount.sa_name
  storage_container_name = module.storagecontainer.container_name
  blob_name = "tfblob"

}

module "k8s" {
  source = "../modules/kubernetes/cluster"

  cluster_name        = "tfaks"
  location            = azurerm_resource_group.rg.location
  rg_name             = azurerm_resource_group.rg.name
  kubernetes_version  = "1.18.8" 
  dns_prefix          = "tfaks"
  node_count          = 1
  vm_size             = "Standard_D2_v2"
}
