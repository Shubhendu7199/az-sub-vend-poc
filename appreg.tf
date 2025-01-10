
resource "azuread_application" "app_registration" {
  count        = local.total_app_regs
  display_name = "app-registration-${count.index + 1}"
}

resource "azurerm_role_assignment" "contributor_assignment" {
  count                = local.total_app_regs
  principal_id         = azuread_application.app_registration[count.index].id
  role_definition_name = "Contributor"
  scope                = module.subscription_vending.subscription_id[count.index].subscription_id
}
