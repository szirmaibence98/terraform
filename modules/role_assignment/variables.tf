variable "scope" {
  description = "The scope the role assignment applies to."
  type        = string
}

variable "role_definition_name_or_id" {
  description = "The name or ID of the role definition to assign."
  type        = string
}

variable "principal_id" {
  description = "The ID of the principal (user, group, service principal, or managed identity) to assign the role to."
  type        = string
}
