locals {

  truefoundry_unique_name = substr(replace("${var.unique_name}", "-", ""), 0, 20)
  svcfoundry_unique_name  = substr(replace("svc-${var.unique_name}", "-", ""), 0, 20)
  mlfoundry_unique_name   = substr(replace("mlf-${var.unique_name}", "-", ""), 0, 20)

  truefoundry_db_port            = 5432
  truefoundry_db_master_username = "truefoundry_root"

  tags = merge(
    {
      "terraform-module" = "terraform-azc-truefoundry"
      "terraform"        = "true"
    },
    var.tags
  )
}