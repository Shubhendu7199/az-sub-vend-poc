# Create the subscription
resource "azurerm_subscription" "main" {
  alias             = "shubhendusub"
  subscription_name = var.subscription_name
  subscription_id   = "10e0ad56-8242-45e7-b95a-a64f4eb4542f"
}

# Assign subscription to management group
resource "azurerm_management_group_subscription_association" "main" {
  count               = var.enable_management_group_association == true ? 1 : 0
  management_group_id = "/providers/Microsoft.Management/managementGroups/${var.management_group_id}"
  subscription_id     = "/subscriptions/${azurerm_subscription.main.subscription_id}"
}

data "azurerm_subscription" "newsubscription" {
  subscription_id = azurerm_subscription.main.subscription_id
}