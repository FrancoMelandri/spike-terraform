resource "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  location            = var.location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  
  default_node_pool  {
    name                  = "default"
    node_count            = var.node_count
    vm_size               = var.vm_size
    os_disk_size_gb       = 100
    enable_node_public_ip = false
  }
  identity {
    type = "SystemAssigned"
  }
  role_based_access_control {
    enabled = true
  }
}