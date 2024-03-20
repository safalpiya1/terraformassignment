output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.workspace.name
}

output "recovery_vault_name" {
  value = azurerm_recovery_services_vault.vault.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}
