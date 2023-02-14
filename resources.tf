resource "anypoint_amq" "amq_dlq_list" {
  count = length(local.dlq_list)

  org_id = var.business_group
  env_id = lookup(local.env_map, element(local.dlq_list, count.index).environment).id
  region_id = lookup(element(local.dlq_list, count.index), "region", var.region)

  queue_id = element(local.dlq_list, count.index).name

  fifo = lookup(element(local.dlq_list, count.index), "fifo", var.dlq_fifo)
  encrypted = lookup(element(local.dlq_list, count.index), "encrypted", var.dlq_encrypted)
  default_ttl =  lookup(element(local.dlq_list, count.index), "default_ttl", var.dlq_default_ttl)
  default_lock_ttl = lookup(element(local.dlq_list, count.index), "default_lock_ttl", var.dlq_default_lock_ttl)
  default_delivery_delay = lookup(element(local.dlq_list, count.index), "default_delivery_delay", var.dlq_default_delivery_delay)

}

resource "anypoint_amq" "amq_list" {
  depends_on = [
    anypoint_amq.amq_dlq_list
  ]
  count = length(local.queues_list)

  org_id = var.business_group
  env_id = lookup(local.env_map, element(local.queues_list, count.index).environment).id
  region_id = lookup(element(local.queues_list, count.index), "region", var.region)

  queue_id = element(local.queues_list, count.index).name

  fifo = lookup(element(local.queues_list, count.index), "fifo", var.q_fifo)
  encrypted = lookup(element(local.queues_list, count.index), "encrypted", var.q_encrypted)
  default_ttl = lookup(element(local.queues_list, count.index), "default_ttl", var.q_default_ttl)
  default_lock_ttl = lookup(element(local.queues_list, count.index), "default_lock_ttl", var.q_default_lock_ttl)
  default_delivery_delay = lookup(element(local.queues_list, count.index), "default_delivery_delay", var.q_default_delivery_delay)
  dead_letter_queue_id = lookup(element(local.queues_list, count.index), "dlq", "") != "" ? element(local.queues_list, count.index).dlq : null
  max_deliveries =  lookup(element(local.queues_list, count.index), "max_deliveries", "") != "" ? element(local.queues_list, count.index).max_deliveries : null

}

resource "anypoint_ame" "ame_list" {
  count = length(local.exchanges_list)

  org_id = var.business_group
  env_id = lookup(local.env_map, element(local.exchanges_list, count.index).environment).id
  region_id = lookup(element(local.exchanges_list, count.index), "region", var.region)

  exchange_id = element(local.exchanges_list, count.index).name

  encrypted = lookup(element(local.exchanges_list, count.index), "encrypted", var.ex_default_encrypted)
}

resource "anypoint_ame_binding" "bindings_list" {
  depends_on = [
    anypoint_ame.ame_list,
    anypoint_amq.amq_list
  ]
  count = length(local.bindings_list)

  org_id = var.business_group
  env_id = lookup(local.env_map, element(local.bindings_list, count.index).environment).id
  region_id = lookup(element(local.bindings_list, count.index), "region", var.region)

  exchange_id = element(local.bindings_list, count.index).exchange
  queue_id = element(local.bindings_list, count.index).queue

  dynamic "rule_str_compare" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_str_compare" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }

  dynamic "rule_str_state" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_str_state" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }

  dynamic "rule_str_set" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_str_set" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }

  dynamic "rule_num_compare" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_num_compare" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }

  dynamic "rule_num_state" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_num_state" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }

  dynamic "rule_num_set" {
    for_each = lookup(element(local.bindings_list, count.index), "rule", {name = ""}).name == "rule_num_set" ? toset([1]) : toset([])
    content {
      property_name = element(local.bindings_list, count.index).rule.property_name
      property_type = element(local.bindings_list, count.index).rule.property_type
      matcher_type = element(local.bindings_list, count.index).rule.matcher_type
      value = element(local.bindings_list, count.index).rule.value
    }
  }
}