resource "anypoint_amq" "amq_list" {
  count = length(local.queues_list)

  org_id = lookup(local.data_bg_map, element(local.queues_list, count.index).business_group).id
  env_id = element(lookup(local.data_envs_map, "${element(local.queues_list, count.index).business_group}:${element(local.queues_list, count.index).environment}"),0).id
  region_id = element(local.queues_list, count.index).region
  queue_id = element(local.queues_list, count.index).name

  fifo = element(local.queues_list, count.index).fifo
  encrypted = element(local.queues_list, count.index).encrypted
  default_ttl = element(local.queues_list, count.index).default_ttl != "" ? element(local.queues_list, count.index).default_ttl : null
  default_lock_ttl = element(local.queues_list, count.index).default_lock_ttl != "" ? element(local.queues_list, count.index).default_lock_ttl : null
  default_delivery_delay = element(local.queues_list, count.index).default_delivery_delay != "" ? element(local.queues_list, count.index).default_delivery_delay : null
  dead_letter_queue_id = element(local.queues_list, count.index).dlq != "" ? element(local.queues_list, count.index).dlq : null
  max_deliveries =  element(local.queues_list, count.index).max_deliveries != "" ? element(local.queues_list, count.index).max_deliveries : null
}

resource "anypoint_ame" "ame_list" {
  count = length(local.exchanges_list)

  org_id = lookup(local.data_bg_map, element(local.exchanges_list, count.index).business_group).id
  env_id = element(lookup(local.data_envs_map, "${element(local.exchanges_list, count.index).business_group}:${element(local.exchanges_list, count.index).environment}"),0).id
  region_id = element(local.exchanges_list, count.index).region
  exchange_id = element(local.exchanges_list, count.index).name
  encrypted = element(local.exchanges_list, count.index).encrypted
}

resource "anypoint_ame_binding" "bindings_list" {
  depends_on = [
    anypoint_ame.ame_list,
    anypoint_amq.amq_list
  ]
  count = length(local.bindings_list)

  org_id = lookup(local.data_bg_map, element(local.bindings_list, count.index).business_group).id
  env_id = element(lookup(local.data_envs_map, "${element(local.bindings_list, count.index).business_group}:${element(local.bindings_list, count.index).environment}"),0).id
  region_id = element(local.bindings_list, count.index).region
  exchange_id = element(local.bindings_list, count.index).exchange
  queue_id = element(local.bindings_list, count.index).queue

  dynamic "rule_str_compare" {
    for_each = element(local.bindings_list, count.index).rule == "rule_str_compare" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = element(local.bindings_list, count.index).value
    }
  }

  dynamic "rule_str_state" {
    for_each = element(local.bindings_list, count.index).rule == "rule_str_state" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = tobool(element(local.bindings_list, count.index).value)
    }
  }

  dynamic "rule_str_set" {
    for_each = element(local.bindings_list, count.index).rule == "rule_str_set" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = split(local.csv_cell_separator, element(local.bindings_list, count.index).value)
    }
  }

  dynamic "rule_num_compare" {
    for_each = element(local.bindings_list, count.index).rule == "rule_num_compare" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = element(local.bindings_list, count.index).value
    }
  }

  dynamic "rule_num_state" {
    for_each = element(local.bindings_list, count.index).rule == "rule_num_state" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = tobool(element(local.bindings_list, count.index).value)
    }
  }

  dynamic "rule_num_set" {
    for_each = element(local.bindings_list, count.index).rule == "rule_num_set" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).property_name
      property_type = element(local.bindings_list, count.index).property_type
      matcher_type = element(local.bindings_list, count.index).matcher_type
      value = split(local.csv_cell_separator, element(local.bindings_list, count.index).value)
    }
  }
}