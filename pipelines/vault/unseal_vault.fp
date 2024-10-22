pipeline "unseal_vault" {
  title       = "Unseal Vault"
  description = "Used to enter a single root key share to progress the unsealing of the Vault."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.vault
    description = local.conn_param_description
    default     = connection.vault.default
  }

  param "key" {
    type        = string
    description = "Specifies a single root key share."
  }

  step "http" "unseal_vault" {
    method = "post"
    url    = "${param.conn.address}/v1/sys/unseal"

    request_headers = {
      "Content-Type"  = "application/json"
      "X-Vault-Token" = param.conn.token
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
