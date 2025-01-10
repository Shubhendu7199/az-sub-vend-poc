opgroup = "shubh"
subscription_list = [
  {
    subscription_name                   = "shubhendusub-1"
    management_group_id                 = "azure-poe"
    is_connectivity_sub                 = true
    connectivity_hub_locations          = ["ase", "gwc", "ue2", "uks", "san", "inc", "ae", "uan"]
    enable_management_group_association = true
    key                                 = 6
  }
]