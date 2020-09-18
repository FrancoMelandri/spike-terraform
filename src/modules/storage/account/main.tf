resource "azurerm_storage_account" "sa" {
 
  name                      = var.account_name
  resource_group_name       = var.rg_name
  location                  = var.location
  allow_blob_public_access  = false
  enable_https_traffic_only = false
  account_tier              = "Standard"
  account_kind              = "StorageV2" 
  account_replication_type  = "GRS"

}

