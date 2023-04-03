data "azurerm_cdn_frontdoor_endpoint" "origins" {
  for_each = local.front_door_endpoints

  name                = each.value.name
  profile_name        = each.value.profile_name
  resource_group_name = each.value.resource_group_name
}