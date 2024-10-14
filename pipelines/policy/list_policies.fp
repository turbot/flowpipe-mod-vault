pipeline "list_policies" {
  title       = "List Policies"
  description = "Lists all configured policies."

  param "conn" {
    type        = connection.vault
    description = local.conn_param_description
    default     = connection.vault.default
  }

  step "http" "list_policies" {
    method = "get"
    url    = "${param.conn.address}/v1/sys/policy"

    request_headers = {
      "X-Vault-Token" = param.conn.token
    }
  }

  output "policies" {
    description = "The list of configured policies."
    value       = step.http.list_policies.response_body.policies
  }
}
