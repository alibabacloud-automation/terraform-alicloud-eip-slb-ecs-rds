data "alicloud_db_zones" "default" {
}

data "alicloud_images" "default" {
  name_regex = "^centos_6"
}

data "alicloud_instance_types" "default" {
  availability_zone = data.alicloud_db_zones.default.zones.0.id
}

data "alicloud_db_instance_classes" "default" {
  engine         = "MySQL"
  engine_version = "5.6"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/12"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_db_zones.default.zones.0.id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "example" {
  source = "../.."

  #alicloud_eip
  eip_bandwidth            = var.eip_bandwidth
  eip_internet_charge_type = "PayByTraffic"

  #alicloud_slb_load_balancer
  name             = var.name
  slb_address_type = "intranet"
  slb_spec         = var.slb_spec
  vswitch_id       = module.vpc.this_vswitch_ids[0]
  slb_tags_info    = var.slb_tags_info

  #alicloud_instance
  availability_zone          = data.alicloud_db_zones.default.zones.0.id
  security_group_ids         = [module.security_group.this_security_group_id]
  instance_type              = data.alicloud_instance_types.default.instance_types.0.id
  system_disk_category       = "cloud_efficiency"
  system_disk_name           = var.system_disk_name
  system_disk_description    = var.system_disk_description
  image_id                   = data.alicloud_images.default.images.0.id
  internet_max_bandwidth_out = var.internet_max_bandwidth_out
  ecs_size                   = 1200
  data_disks_name            = "data_disks_name"
  category                   = "cloud_efficiency"
  description                = "tf-description"
  encrypted                  = true

  #alicloud_db_instance
  engine               = "MySQL"
  engine_version       = "5.6"
  rds_instance_type    = data.alicloud_db_instance_classes.default.instance_classes.1.instance_class
  instance_storage     = var.instance_storage
  instance_charge_type = var.instance_charge_type
  monitoring_period    = var.monitoring_period

}
