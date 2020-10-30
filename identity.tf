resource "oci_identity_user" "cm_backup_user" {
    compartment_id = var.tenancy_ocid
    description = var.user_description
    name = var.user_name

    email = var.user_email
}

resource "oci_identity_user_capabilities_management" "cm_backup_user_capabilities" {
    user_id = oci_identity_user.cm_backup_user.id

    can_use_api_keys             = "true"
    can_use_auth_tokens          = "false"
    can_use_console_password     = "true"
    can_use_customer_secret_keys = "true"
    can_use_smtp_credentials     = "false"
}

resource "oci_identity_ui_password" "cm_backup_user_password" {
    user_id = oci_identity_user.cm_backup_user.id
}

resource "oci_identity_api_key" "cm_backup_api_key" {
    key_value = tls_private_key.user_api_key.public_key_pem
    user_id = oci_identity_user.cm_backup_user.id
}

# API Key for user
resource "tls_private_key" "user_api_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "oci_identity_group" "cm_backup_group" {
    compartment_id = var.tenancy_ocid
    description = var.group_description
    name = var.group_name
}

resource "oci_identity_user_group_membership" "cm_backup_user_group_membership" {
    group_id = oci_identity_group.cm_backup_group.id
    user_id = oci_identity_user.cm_backup_user.id
}