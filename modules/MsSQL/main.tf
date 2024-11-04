resource "azurerm_resource_group" "sql_rg" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.server_name
  resource_group_name          = azurerm_resource_group.sql_rg.name
  location                     = azurerm_resource_group.sql_rg.location
  version                      = "12.0"
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
  minimum_tls_version          = "1.2"

  tags = {
    environment = "production"
  }
}

resource "azurerm_mssql_database" "name" {
  name = "mssql_db"
  server_id = azurerm_mssql_server.mssql_server.id
  max_size_gb = 10
  min_capacity = 1
  sku_name= "GP_S_Gen5_2"
  auto_pause_delay_in_minutes = -1
}

resource "azurerm_mssql_firewall_rule" "example" {
  name             = "FirewallRule1"
  server_id        = azurerm_mssql_server.mssql_server.id
  start_ip_address = "10.0.17.62"
  end_ip_address   = "10.0.17.62"
}