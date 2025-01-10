locals {
  environment_short = {
    Development = "d"
    Production  = "p"
    Sandbox     = "x"
    Staging     = "s"
    Test        = "t"
  }
  subscriptions = {
    for subscription in var.subscription_list : subscription.key => subscription
  }
  connectivity_subscriptions = {
    for subscription in var.subscription_list : subscription.key => subscription
    if subscription.is_connectivity_sub
  }
  connectivity_subscriptions_list = flatten([
    for subscription in local.connectivity_subscriptions : [
      for location in subscription.connectivity_hub_locations :
      merge(subscription, {
        connectivity_hub_suffix   = subscription.environment != "Production" ? "${location}-${local.environment_short[subscription.environment]}" : "${location}"
        connectivity_hub_location = location
      })
    ]
  ])
  connectivity_subscriptions_by_hub_location = {
    for subscription in local.connectivity_subscriptions_list :
    "${subscription.key}-${subscription.connectivity_hub_location}" => subscription
  }
  paas_subscriptions_list = { for subscription in var.subscription_list : subscription.key => subscription if subscription.is_paas == true }

  nsg_workspace_list = { for subscription in var.subscription_list : subscription.key => subscription }

  total_workspaces = length(local.subscriptions) * 2 * length(local.connectivity_subscriptions_list)
  total_app_regs   = ceil(local.total_workspaces / 10) # For 10 workspaces per app registration

}



################################################################################

