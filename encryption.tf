resource "oci_kms_vault" "cm_vault" {
    compartment_id = var.compartment_ocid
    display_name = "Cloud Manager Vault"
    vault_type = "DEFAULT"
}

# Master Encryption Key for the vault
resource "oci_kms_key" "cm_vault_key" {
    compartment_id = var.compartment_ocid
    display_name = "CM DB Backup Key"
    key_shape {   
        algorithm = "AES"
        length = "32"
    }
    management_endpoint = oci_kms_vault.cm_vault.management_endpoint
}

# Key to encrypt bucket
# resource "oci_kms_generated_key" "cm_backups_bucket_key" {
#     crypto_endpoint = oci_kms_vault.cm_vault.crypto_endpoint
#     include_plaintext_key = true
#     key_id = oci_kms_key.cm_vault_key.id
#     key_shape {
#         algorithm = "AES"
#         length = "32"
#     }
# }

resource "oci_kms_key_version" "cm_backups_bucket_key_version" {
    key_id = oci_kms_key.cm_vault_key.id
    management_endpoint = oci_kms_vault.cm_vault.management_endpoint
}
