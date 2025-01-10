data "tfe_organization" "tfc_organization" {
  name     = var.tfc_organization_name
  provider = tfe.tfc
}

data "tfe_project" "tfc_project" {
  name         = var.tfc_project_name
  organization = var.tfc_organization_name
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_baseline_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.subscriptions
  name         = "azure-baseline-resources-${each.value.subscription_name}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending"]
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_compute_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.subscriptions
  name         = "azure-compute-resources-${each.value.subscription_name}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending", "compute"]
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_firewall_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.connectivity_subscriptions_by_hub_location
  name         = "azure-firewall-${var.opgroup}-${each.value.connectivity_hub_suffix}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending"]
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_connectivity_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.connectivity_subscriptions_by_hub_location
  name         = "azure-connectivity-${var.opgroup}-${each.value.connectivity_hub_suffix}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending"]
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_paas_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.paas_subscriptions_list
  name         = "azure-paas-resources-${each.value.subscription_name}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending", "paas"]
  provider     = tfe.tfc
}

resource "tfe_workspace" "tfc_nsgrules_workspace" {
  depends_on   = [module.subscription_vending]
  for_each     = local.nsg_workspace_list
  name         = "azure-nsg-rules-${each.value.subscription_name}"
  organization = data.tfe_organization.tfc_organization.name
  project_id   = data.tfe_project.tfc_project.id
  tag_names    = ["azure", "subscriptionvending", "paas"]
  provider     = tfe.tfc
}

resource "tfe_variable" "tfc_run_client_id_baseline" {
  depends_on   = [module.subscription_vending]
  for_each     = local.subscriptions
  workspace_id = tfe_workspace.tfc_baseline_workspace[each.key].id
  key          = "TFC_RUN_CLIENT_ID"
  value        = azuread_application.app_registration[floor(tonumber(split("-", each.key)[0]) / 10)].client_id
  category     = "terraform"
}

resource "tfe_variable" "tfc_run_client_id_compute" {
  depends_on   = [module.subscription_vending]
  for_each     = local.subscriptions
  workspace_id = tfe_workspace.tfc_compute_workspace[each.key].id
  key          = "TFC_RUN_CLIENT_ID"
  value        = azuread_application.app_registration[floor(tonumber(split("-", each.key)[0]) / 10)].client_id
  category     = "terraform"
}

resource "tfe_variable" "tfc_run_client_id_firewall" {
  depends_on   = [module.subscription_vending]
  for_each     = local.connectivity_subscriptions_by_hub_location
  workspace_id = tfe_workspace.tfc_firewall_workspace[each.key].id
  key          = "TFC_RUN_CLIENT_ID"
  value        = azuread_application.app_registration[floor(tonumber(split("-", each.key)[0]) / 10)].client_id
  category     = "terraform"
}

resource "tfe_variable" "tfc_run_client_id_connectivity" {
  depends_on   = [module.subscription_vending]
  for_each     = local.connectivity_subscriptions_by_hub_location
  workspace_id = tfe_workspace.tfc_connectivity_workspace[each.key].id
  key          = "TFC_RUN_CLIENT_ID"
  value        = azuread_application.app_registration[floor(tonumber(split("-", each.key)[0]) / 10)].client_id
  category     = "terraform"
}

resource "tfe_variable" "tfc_run_client_id_paas" {
  depends_on   = [module.subscription_vending]
  for_each     = local.paas_subscriptions_list
  workspace_id = tfe_workspace.tfc_paas_workspace[each.key].id
  key          = "TFC_RUN_CLIENT_ID"
  value        = azuread_application.app_registration[floor(tonumber(split("-", each.key)[0]) / 10)].client_id
  category     = "terraform"
}