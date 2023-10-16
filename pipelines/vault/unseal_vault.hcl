pipeline "unseal_vault" {
  title       = "Unseal Vault"
  description = "Used to unseal the Vault"

  param "address" {
    type        = string
    default     = var.address
    description = "The address of the Vault server."
  }

  param "access_token" {
    type        = string
    default     = var.access_token
    description = "The access token to use for the request."
  }

  param "unseal_key" {
    type = string
    // default     = "aN056/ea9XlSGcMODWCo/+h7ZCFSLlLzMxbtIbhUJ20="
    description = "Specifies a single root key share."
  }

  step "http" "unseal_vault" {
    title  = "Unseal Vault"
    method = "post"
    url    = "${param.address}/v1/sys/unseal"

    request_headers = {
      "Content-Type"  = "application/json"
      "X-Vault-Token" = param.access_token
    }

    request_body = jsonencode({
      key : param.unseal_key
    })
  }

  output "seal_status" {
    value       = step.http.unseal_vault.response_body
    description = "The seal status of the Vault server."
  }
}
