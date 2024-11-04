module "sql_db" {
  source = "./modules/MsSQL"
  rg_name = "db_test"
  server_name = "thuan-20521995"
  admin_username = "thuan"
  admin_password = "Thu05033108@"
}

module "AppService" {
  source = "./modules/AppService" 
}
