variable cplane {
  type        = string
  default     = "us"
  description = "Anypoint control plane"
}

variable access_token {
  type        = string
  default     = ""
  description = "the anypoint access token"
}

variable client_id {
  type        = string
  default     = ""
  description = "the anypoint connected app id"
}

variable client_secret {
  type        = string
  default     = ""
  description = "the anypoint connected app secret"
}

variable business_group {
  type        = string
  default     = ""
  description = "the anypoint organization id"
}

variable sub_org_ids {
  type = list(string)
  default = []
  description = "list of existing sub organization ids"
}