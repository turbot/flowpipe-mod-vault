pipeline "create_secret" {
  title       = "Create secret"
  description = "Stores a secret at the specified location."

  tags = {
    type = "featured"
  }

  param "conn" {
    type        = connection.vault
    description = local.conn_param_description
    default     = connection.vault.default
  }

  param "path" {
    type        = string
    description = "Specifies the path of the secrets to create/update."
  }

  param "secret" {
    type        = map
    description = "Specifies the secret data to store."
  }

  step "http" "create_secret" {
    method = "post"
    url    = "${param.conn.address}/v1/secret/${param.path}"

    request_headers = {
      "X-Vault-Token" = param.conn.token
    }

    request_body = jsonencode(param.secret)
  }
}
