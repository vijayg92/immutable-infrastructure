########################################################
################ Terraform Config ######################
########################################################
terraform {
  required_version = ">=0.12"
  required_providers {
    aws = {
      source       = "hashicorp/aws"
      version      = "3.65.0"
    }
  }
}

########################################################
#################### Main Module #######################
########################################################
provider "aws" {
  region = var.aws_region
}

data "aws_ami" "base_ami" {
    executable_users      =  ["self"]
    most_recent           =  true
    name_regex            =  "^webserver-stable*"
    owners                =  ["016393142808"]
}

resource "aws_instance" "webservers" {
    count                       =  var.instance_count
    ami                         =  data.aws_ami.base_ami.id
    instance_type               =  var.instance_type
    key_name                    =  "deployer"
    
    dynamic "root_block_device" {
      for_each = var.root_block_device
      content {
        volume_size  = lookup(root_block_device.value, "volume_size", null)
        volume_type  = lookup(root_block_device.value, "volume_type", null)
        tags         = {
            Name     = "${var.app_name}-rootfs${count.index+1}"
        }
      }
    }

    lifecycle {
      create_before_destroy = true
    }

    tags                   =  {
      Name                 =  join("",[var.app_name, "${count.index+1}"])
    }
}