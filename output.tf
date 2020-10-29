output "user_api_key_public" {
  value = tls_private_key.user_api_key.public_key_pem
}

output "user_api_key_private" {
  value = tls_private_key.user_api_key.private_key_pem
}

output "user_api_key_fingerprint" {
  value = tls_private_key.user_api_key.public_key_fingerprint_md5 
}

output "user_ocid" {
  value = oci_identity_user.cm_backup_user.id
}

output "buckets" {
  value = data.oci_objectstorage_bucket_summaries.cm_db_backups_bucket.bucket_summaries
}

output "namespace" {
  value = data.oci_objectstorage_namespace.ns.namespace
}

output "namespace-metadata" {
  value = <<EOF
  namespace = ${data.oci_objectstorage_namespace_metadata.namespace_metadata.namespace}
  default_s3compartment_id = ${data.oci_objectstorage_namespace_metadata.namespace_metadata.default_s3compartment_id}
  default_swift_compartment_id = ${data.oci_objectstorage_namespace_metadata.namespace_metadata.default_swift_compartment_id}
EOF

}