resource "azurerm_storage_blob" "dfe_403" {
  for_each = local.custom_error_web_pages

  name                   = "dfe/403.html"
  storage_account_name   = each.key
  storage_container_name = "$web"
  type                   = "Block"
  source_content         = each.value["dfe/403.html"]
  content_type           = "text/html"
  access_tier            = "Cool"
}

resource "azurerm_storage_blob" "dfe_502" {
  for_each = local.custom_error_web_pages

  name                   = "dfe/502.html"
  storage_account_name   = each.key
  storage_container_name = "$web"
  type                   = "Block"
  source_content         = each.value["dfe/502.html"]
  content_type           = "text/html"
  access_tier            = "Cool"
}

resource "azurerm_storage_blob" "govuk_403" {
  for_each = local.custom_error_web_pages

  name                   = "govuk/403.html"
  storage_account_name   = each.key
  storage_container_name = "$web"
  type                   = "Block"
  source_content         = each.value["govuk/403.html"]
  content_type           = "text/html"
  access_tier            = "Cool"
}

resource "azurerm_storage_blob" "govuk_502" {
  for_each = local.custom_error_web_pages

  name                   = "govuk/502.html"
  storage_account_name   = each.key
  storage_container_name = "$web"
  type                   = "Block"
  source_content         = each.value["govuk/502.html"]
  content_type           = "text/html"
  access_tier            = "Cool"
}
