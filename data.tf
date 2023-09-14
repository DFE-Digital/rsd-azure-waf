data "azurerm_resource_group" "container_apps" {
  for_each = local.container_app_targets

  name = each.value.resource_group
}

data "azurerm_container_app" "container_apps" {
  for_each = local.container_app_targets

  name                = each.key
  resource_group_name = data.azurerm_resource_group.container_apps[each.key].name
}

data "azurerm_windows_web_app" "web_apps" {
  for_each = local.windows_web_app_service_targets

  name                = each.key
  resource_group_name = each.value.resource_group
}

data "azurerm_linux_web_app" "web_apps" {
  for_each = local.linux_web_app_service_targets

  name                = each.key
  resource_group_name = each.value.resource_group
}
