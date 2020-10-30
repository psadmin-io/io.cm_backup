resource "oci_objectstorage_bucket" "cm_db_backups_bucket" {
    compartment_id = var.compartment_ocid
    name = var.bucket_name
    namespace = data.oci_objectstorage_namespace.ns.namespace

    # There is a bug that prevents us from using our keys
    # Using the oracle keys for now and create an SR
    # kms_key_id = oci_kms_key.cm_vault_key.id
}

resource "oci_objectstorage_object_lifecycle_policy" "cm_db_lifecycle_policy" {
    depends_on = [oci_identity_policy.cm_backups_bucket_policy]
    bucket = oci_objectstorage_bucket.cm_db_backups_bucket.name
    namespace = data.oci_objectstorage_namespace.ns.namespace

    rules {
        action = "ARCHIVE"
        is_enabled = "true"
        name = "cm-db-backup-archive"
        time_amount = var.archive_days
        time_unit = "DAYS"

        object_name_filter {
            exclusion_patterns = ["*.xml"]
        }
        target = "objects"
    }

    rules {
        action      = "ABORT"
        is_enabled  = "true"
        name        = "upload-abort-10-days"
        time_amount = "10"
        time_unit   = "DAYS"

        target = "multipart-uploads"
    }
}

data "oci_objectstorage_bucket_summaries" "cm_db_backups_bucket" {
  compartment_id = var.compartment_ocid
  namespace      = data.oci_objectstorage_namespace.ns.namespace

  filter {
    name   = "name"
    values = [oci_objectstorage_bucket.cm_db_backups_bucket.name]
  }
}

data "oci_objectstorage_namespace" "ns" {
  compartment_id = var.compartment_ocid
}

data "oci_objectstorage_namespace_metadata" "namespace_metadata" {
  namespace = data.oci_objectstorage_namespace.ns.namespace
}