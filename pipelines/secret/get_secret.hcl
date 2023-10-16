pipeline "get_secret" {
  title       = "Get Secret"
  description = "Read secret data from HashiCorp Vault."

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

  step "http" "get_secret" {
    title  = "Read Vault Secret Data"
    method = "get"
    url    = "${param.address}/v1/sys/mounts"

    request_headers = {
      "X-Vault-Token" = param.access_token
    }
  }

  output "secret_data" {
    value       = jsondecode(step.http.get_secret.response_body)
    description = "The secret data from Vault."
  }
}
