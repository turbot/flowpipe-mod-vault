variable "access_token" {
  type        = string
  description = "The Hashicorp personal security access token to authenticate to the Hashicorp APIs."
}

variable "address" {
  type        = string
  description = "The address of the Hashicorp Vault server. eg., http://localhost:8200"
}
