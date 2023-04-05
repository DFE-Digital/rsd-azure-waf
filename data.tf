data "azurerm_resource_group" "container_apps" {
  for_each = var.container_app_origins

  name = each.value.resource_group
}

data "azapi_resource" "container_apps" {
  for_each = local.container_app_origin_group_with_resource_ids

  name      = each.value.name
  parent_id = each.value.resource_group_id
  type      = "Microsoft.App/containerApps@2022-03-01"

  response_export_values = [
    "properties.configuration.ingress.fqdn",
  ]
}
