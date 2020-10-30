resource "oci_identity_policy" "cm_backups_bucket_policy" {
    depends_on = [oci_identity_group.cm_backup_group]
    compartment_id = var.tenancy_ocid
    description = "Cloud Manager Backup Policies"
    name = "CloudManagerBackup"
    statements = [
      "Allow group ${var.group_name} to manage buckets in compartment id ${var.compartment_ocid} where all {target.bucket.name='${var.bucket_name}'}",
      "Allow group ${var.group_name} to manage objects in compartment id ${var.compartment_ocid} where all {target.bucket.name='${var.bucket_name}'}",
      "Allow group ${var.group_name} to read all-resources in compartment id ${var.compartment_ocid}",
      "Allow service objectstorage-${var.region} to manage object-family in compartment id ${var.compartment_ocid} where all {target.bucket.name='${var.bucket_name}'}"
    ]
}