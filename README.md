# Cloud Manager Backups

This Terraform module will set up the infrastructure necessary to perform Cloud Manager database and volume backups.

## Database Backups

The module will create an Object Storage bucket, a user in OCI, and an API key for the user to use for database backups.

The module can also be used to set a backup policy on the Cloud Manager data volume.

To finish backups to Cloud Manager, follow the steps in this blog post:

## Module Usage

`cm_backup.tf`
```terraform
module "cm_backup" {
  source              = "github.com/psadmin-io/io.cm_backup"

  tenancy_ocid = "ocid1.tenancy.oc1.."
  region = "us-ashburn-1"
  compartment_ocid = "ocid1.compartment.oc1.."
  bucket_name = "CM_Backups"

  # CM Backup User
  user_name = "cmbackups"
  user_description = "Cloud Manager Backups"
  user_email = "dan@example.com"
  group_name = "DBBackupUsers"
  group_description = "Database Backup Users"

  # CM Data Volume
  enable_volume_backup = true
  cm_data_volume_ocid = "ocid1.volume.oc1.iad."
}

output "user_api_key_private" {
  value = module.cm_backup.user_api_key_private
}
output "user_ocid" {
  value = module.cm_backup.user_ocid
}
output = "user_api_key_fingerprint" {
  value = module.cm_backup.user_api_key_fingerprint
}
```

Initialize Terraform and run the plan.

```bash
$ terraform init
$ terraform plan
```

## Options

You can optionally enable volume backups for the Cloud Manager data drive.

Set `enable_volume_backup = true`, and then set the OCID for the block volume - `cm_data_volume_ocid = "ocid1.volume.oc1.iad."`. 

The default for `enable_volume_backup` is `false` if you choose not to use that.


  