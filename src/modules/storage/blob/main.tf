resource "azurerm_storage_blob" "blob" {
 
  name                    = var.blob_name
  storage_account_name    = var.storage_account_name
  storage_container_name  = var.storage_container_name 
  type                    = "Page"
  size                    = 512
}

