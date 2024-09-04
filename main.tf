provider "vault" {}
# These variables are inherited from our dcvs
variable "ddr_user_slug" {}
variable "ddr_vault_public_endpoint" {}
# You must create this variable in your workspace. Mark it
# sensitive
variable "ddr_ui_password" {
  type      = string
  sensitive = true
}
resource "vault_generic_endpoint" "ddr_ui_password" {
  path = "auth/ddr-ui/users/${var.ddr_user_slug}/password"
  disable_read = true
  disable_delete = true
  ignore_absent_fields = true
  data_json = jsonencode({
    password = var.ddr_ui_password
  })
}
output "shared_vault_ui" {
  description = "Go here to access the Shared Vault UI. Log in using `ddr-ui`"
  value       = var.ddr_vault_public_endpoint
}
output "shared_vault_username" {
  description = "Use this as the 'username' in the Shared Vault UI."
  value       = var.ddr_user_slug
}