locals {
  csv_folder = "${path.module}/csv"
  # separator of one single cell having list of values
  csv_cell_separator = ";"

  queues_data = file("${local.csv_folder}/queues.csv")
  exchanges_data = file("${local.csv_folder}/exchanges.csv")
  bindings_data = file("${local.csv_folder}/bindings.csv")

  queues_list = csvdecode(local.queues_data)
  exchanges_list = csvdecode(local.exchanges_data)
  bindings_list = csvdecode(local.bindings_data)

  #list of sub_orgs
  sub_org_ids = data.anypoint_bg.bg.sub_organization_ids

  # list of all bgs
  all_bgs_list = concat([data.anypoint_bg.bg], data.anypoint_bg.sub_bgs)

  #map of all business groups
  data_bg_map = {
    for b in local.all_bgs_list : b.name => b
  }

  #list of all created environments cross bgs
  data_envs_map = {
    for e in flatten([
      for b in local.all_bgs_list : [
        for env in b.environments : merge(
          {
            key = "${b.name}:${env.name}"
            bg_name = b.name
          }, env)
      ]
    ]) : e.key => e...
  }

}


#ROOT BG
data "anypoint_bg" "bg" {
  id = var.business_group
}

#EXISTING SUB BGs
data "anypoint_bg" "sub_bgs" {
  count = length(local.sub_org_ids)
  id = element(local.sub_org_ids, count.index)
  depends_on = [
    data.anypoint_bg.bg
  ]
}
