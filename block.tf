data "oci_core_volume_backup_policies" "silver" {
  filter {
    name   = "display_name"
    values = ["silver"]
  }
}

resource "oci_core_volume_backup_policy_assignment" "cm_data_volume_backup_policy_assignment" {
    count     = var.enable_volume_backup==true ? 1 : 0
    asset_id  = var.cm_data_volume_ocid
    policy_id = data.oci_core_volume_backup_policies.silver.volume_backup_policies[0].id
}