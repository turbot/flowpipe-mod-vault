pipeline "unseal_vault" {
  title       = "Unseal Vault"
  description = "Used to enter a single root key share to progress the unsealing of the Vault."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "key" {
    type        = string
    description = "Specifies a single root key share."
  }

  step "http" "unseal_vault" {
    method = "post"
    url    = "${credential.vault[param.cred].address}/v1/sys/unseal"

    request_headers = {
      "Content-Type"  = "application/json"
      "X-Vault-Token" = credential.vault[param.cred].token
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
