module "subscription_vending" {
  source                              = "./module"
  for_each                            = local.subscriptions
  key                                 = each.value.key
  subscription_name                   = each.value.subscription_name
  is_connectivity_sub                 = try(each.value.is_connectivity_sub, false)
  is_arc_enabled                      = try(each.value.is_arc_enabled, false)
  is_avs_enabled                      = try(each.value.is_avs_enabled, false)
  management_group_id                 = each.value.management_group_id
  enable_management_group_association = each.value.enable_management_group_association
  deploy_default_resources            = try(each.value.deploy_default_resources, false)
}

# output "subscriptions" {
#   value = join(",", [for val in module.subscription_vending : val.subscription_id])
# }