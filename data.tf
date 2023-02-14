locals {
  csv_folder = "${path.module}/input"

  dlq_data = file("${local.csv_folder}/dlq.json")
  queues_data = file("${local.csv_folder}/queues.json")
  exchanges_data = file("${local.csv_folder}/exchanges.json")
  bindings_data = file("${local.csv_folder}/bindings.json")

  raw_dlq_list = jsondecode(local.dlq_data)
  raw_queues_list = jsondecode(local.queues_data)
  raw_exchanges_list = jsondecode(local.exchanges_data)
  raw_bindings_list = jsondecode(local.bindings_data)

  dlq_list = flatten([
    for q in local.raw_dlq_list: [
      for env in q.environments: merge({environment = env}, q)
    ]
  ])
  queues_list = flatten([
    for q in local.raw_queues_list: [
      for env in q.environments: merge({environment = env}, q)
    ]
  ])
  exchanges_list = flatten([
    for ex in local.raw_exchanges_list: [
      for env in ex.environments: merge({environment = env}, ex)
    ]
  ])
  bindings_list = flatten([
    for b in local.raw_bindings_list: [
      for env in b.environments: merge({environment = env}, b)
    ]
  ])

  #map of all created environments in the given bg
  env_map = {
    for env in data.anypoint_bg.bg.environments : env.name => env
  }

}


#ROOT BG
data "anypoint_bg" "bg" {
  id = var.business_group
}

