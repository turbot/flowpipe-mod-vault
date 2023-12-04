pipeline "unseal_vault" {
  title       = "Unseal Vault"
  description = "Used to enter a single root key share to progress the unsealing of the Vault."

  param "address" {
    type        = string
    description = local.address_param_description
    default     = var.address
  }

  param "access_token" {
    type        = string
    description = local.access_token_param_description
    default     = var.access_token
  }

  param "key" {
    type        = string
    description = "Specifies a single root key share."
  }

  step "http" "unseal_vault" {
    method = "post"
    url    = "${param.address}/v1/sys/unseal"

    request_headers = {
      "Content-Type"  = "application/json"
      "X-Vault-Token" = param.access_token
    }

    request_body = jsonencode({
      key : param.key
    })
  }

  output "seal_status" {
    description = "The seal status of the Vault server."
    value       = step.http.unseal_vault.response_body
  }
}
