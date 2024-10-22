pipeline "list_secrets" {
  title       = "List Secrets"
  description = "Returns a list of key names at the specified location."

  param "conn" {
    type        = connection.vault
    description = local.conn_param_description
    default     = connection.vault.default
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secrets to list."
    optional    = true
  }

  step "http" "list_secrets" {
    method = "get"
    url    = "${param.conn.address}/v1/secret/${param.path != null ? param.path : ""}?list=true"

    request_headers = {
      "X-Vault-Token" = param.conn.token
    }
  }

  output "keys" {
    description = "The list of key names at the specified location."
    value       = step.http.list_secrets.response_body.data.keys
  }
}
