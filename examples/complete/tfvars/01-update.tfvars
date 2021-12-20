##############################################################
#variables for alicloud_slb_load_balancer
##############################################################
name                = "terraform-slb-load-balancer-update"
slb_tags_info       = "create for internet update"
slb_spec            = "slb.s2.medium"
##############################################################
#variables for alicloud_db_instance
##############################################################
rds_instance_type     = "rds.mysql.t1.small"
instance_storage      = 50
instance_charge_type  = "Postpaid"
monitoring_period     = "300"
eip_bandwidth         = "5"
##############################################################
#variables for alicloud_instance
##############################################################
system_disk_name            = "system_disk_update"
system_disk_description     = "system_disk_description_update"
image_id                    = "centos_7_03_64_20G_alibase_20170818.vhd"
instance_type               = "ecs.s6-c1m2.small"
internet_max_bandwidth_out  = 20
period  = 2
