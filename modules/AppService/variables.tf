variable "resource_group_name" {
  type    = string
  default = "test1"
}

variable "location" {
  type    = string
  default = "Southeast Asia"  # Specify your preferred location
}

variable "app_service_name" {
  type    = string
  default = "thuan-20521995"
}

variable "app_service_plan_name" {
  type    = string
  default = "test"
}

variable "github_repo" {
  type    = string
  default = "https://github.com/ntthuan0106/plothole_api"
}

variable "github_branch" {
  type    = string
  default = "master"  # e.g., "main"
}

variable "github_token" {
  type      = string
  sensitive = true
  default = "token"
}