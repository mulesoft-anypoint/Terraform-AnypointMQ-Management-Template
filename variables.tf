variable "cplane" {
  type        = string
  default     = "us"
  description = "Anypoint control plane"
}

variable "access_token" {
  type        = string
  default     = ""
  description = "the anypoint access token"
}

variable "client_id" {
  type        = string
  default     = ""
  description = "the anypoint connected app id"
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "the anypoint connected app secret"
}

variable "business_group" {
  type        = string
  default     = ""
  description = "the anypoint organization id"
}

variable "region" {
  type = string
  default = ""
  description = "the region where the queues will be created"
}

variable "q_default_ttl" {
  type = number
  default = 604800000
  description = "the default time (in ms) to live for a message in a queue"
}

variable "q_default_lock_ttl" {
  type = number
  default = 900000
  description = "the default time (in ms) where a message is locked before it can be consumed again"
}

variable "q_default_delivery_delay" {
  type = number
  default = 0
  description = "the default delivery delay for a message in a queue in seconds"
}

variable "q_encrypted" {
  type = number
  default = false
  description = "whether to encrypt by default the queues"
}

variable "q_fifo" {
  type = number
  default = false
  description = "whether to make queues fifo type"
}

variable "dlq_default_ttl" {
  type = number
  default = 604800000
  description = "the default time (in ms) to live for a message in a dead letter queue"
}

variable "dlq_default_lock_ttl" {
  type = number
  default = 900000
  description = "the default time (in ms) where a message is locked before it can be consumed again in a dead letter queue"
}

variable "dlq_default_delivery_delay" {
  type = number
  default = 0
  description = "the default delivery delay for a message in a dead letter queue in seconds"
}

variable "dlq_encrypted" {
  type = number
  default = false
  description = "whether to encrypt by default the dead letter queues"
}

variable "dlq_fifo" {
  type = number
  default = false
  description = "whether to make the dead letter queues fifo"
}

variable "ex_default_encrypted" {
  type = number
  default = false
  description = "whether to encrypt by default the exchanges"
}
