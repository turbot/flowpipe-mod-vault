pipeline "list_policies" {
  title       = "List Policies"
  description = "Lists all configured policies."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = var.default_cred
  }

  step "http" "list_policies" {
    method = "get"
    url    = "${credential.vault[param.cred].address}/v1/sys/policy"

    request_headers = {
      "X-Vault-Token" = credential.vault[param.cred].token
    }
  }

  output "policies" {
    description = "The list of configured policies."
    value       = step.http.list_policies.response_body.policies
  }
}
