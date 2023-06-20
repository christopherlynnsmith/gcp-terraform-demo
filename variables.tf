variable "project_id" {
  description = "Google Project ID."
  type        = string
  default     = "seed-390122"
}

# groups configuration variables
variable "devops_display_name" {
  description = "group display name"
  type        = string
  default     = ""
}

variable "devops_description" {
  description = "group description"
  type        = string
  default     = ""
}

variable "devops_initial_group_config" {
  description = "group description"
  type        = string
  default     = "WITH_INITIAL_OWNER"
}


variable "cloud_identity_org_parent" {
  description = "group description"
  type        = string
  default     = "customers/C00n10ucq"
}

variable "devops_principal" {
  description = "group description"
  type        = string
  default     = "devops@globalmatchpassport.com"
}

