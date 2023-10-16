variable "access_token" {
  type        = string
  description = "The Hashicorp personal security access_token to authenticate to the Hashicorp APIs."
}

variable "address" {
  type        = string
  description = "The address of the Hashicorp Vault server."
}

variable "auth_type" {
  type        = string
  default     = "token"
  description = "The authentication type to use when authenticating to the Hashicorp Vault server."
}