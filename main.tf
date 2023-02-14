terraform {
  required_providers {
    anypoint = {
      # source = "mulesoft-anypoint/anypoint"
      # version = "1.5.1"
      source = "anypoint.mulesoft.com/automation/anypoint"
    }
  }
}

provider "anypoint" {
  access_token = var.access_token != "" ? var.access_token : ""
  client_id = var.client_id != "" ? var.client_id : ""
  client_secret = var.client_secret != "" ? var.client_secret : ""
  cplane= var.cplane
}