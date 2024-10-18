pipeline "get_secret" {
  title       = "Get Secret"
  description = "Retrieves the secret at the specified location."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.vault
    description = local.conn_param_description
    default     = connection.vault.default
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secret to read."
  }

  step "http" "get_secret" {
    method = "get"
    url    = "${param.conn.address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = param.conn.token
    }
  }

  output "secret" {
    description = "The secret at the specified location."
    value       = step.http.get_secret.response_body.data
  }
}
