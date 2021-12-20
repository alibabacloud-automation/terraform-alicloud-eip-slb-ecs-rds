data "alicloud_zones" "default" {
  available_instance_type = var.instance_type
  enable_details = true
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_name           = "my_module_vpc"
  vpc_cidr           = "172.16.0.0/12"
  vswitch_name       = "my_module_vswitch"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_zones.default.ids.0]
}

module "security-group" {
  source  = "alibaba/security-group/alicloud"
  name        = "user-service"
  description = "Security group for user-service with custom rules of source security group."
  vpc_id      = module.vpc.vpc_id
}

module "example" {
  source                      = "../.."
  name                        = var.name
  security_group_ids          = [module.security-group.this_security_group_id]
  vswitch_id                  = module.vpc.vswitch_ids[0]
  availability_zone           = data.alicloud_zones.default.zones.0.id
  description                 = "disk2"
  instance_type               = var.instance_type
  system_disk_category        = "cloud_efficiency"
  system_disk_name            = var.system_disk_name
  system_disk_description     = var.system_disk_description
  image_id                    = var.image_id
  internet_max_bandwidth_out  = var.internet_max_bandwidth_out
  ecs_size                    = 1200
  category                    = "cloud_efficiency"
  engine                      = "MySQL"
  engine_version              = "5.6"
  rds_instance_type           = var.rds_instance_type
  period                      = var.period
  instance_storage            = var.instance_storage
  instance_charge_type        = var.instance_charge_type
  monitoring_period           = var.monitoring_period
  slb_address_type            = "intranet"
  slb_spec                    = var.slb_spec
  slb_tags_info               = var.slb_tags_info
  eip_bandwidth               = var.eip_bandwidth
  eip_internet_charge_type    = "PayByBandwidth"
  data_disks_name             = "data_disk2"
}
