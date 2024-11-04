# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Create an App Service Plan
resource "azurerm_service_plan" "app_service_plan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type = "Linux"
  sku_name = "B1"
}

# Create the web app, pass in the App Service Plan ID
resource "azurerm_linux_web_app" "webapp" {
  name                  = var.app_service_name
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  service_plan_id       = azurerm_service_plan.app_service_plan.id
  https_only            = true
  site_config { 
    minimum_tls_version = "1.2"
    application_stack {
      dotnet_version = "8.0"
    }
  }
}

#  Deploy code from a public GitHub repo
resource "azurerm_app_service_source_control" "sourcecontrol" {
  app_id             = azurerm_linux_web_app.webapp.id
  repo_url           = var.github_repo
  branch             = var.github_branch
  use_manual_integration = false
  use_mercurial      = false
  github_action_configuration {
    code_configuration {
      runtime_stack = "dotnetcore"
      runtime_version = "8.0"
    }
    generate_workflow_file = true
  }
}

resource "azurerm_source_control_token" "example" {
  type  = "GitHub"
  token = var.github_token
}