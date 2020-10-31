variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "region" {}
variable "bucket_name" {}

variable "group_name" {}

variable "archive_days" {
  default = "60"
}

variable "enable_volume_backup" {
  default = false
}
variable "cm_data_volume_ocid" {
  default = ""
}