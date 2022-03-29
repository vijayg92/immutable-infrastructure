########################################################
################# Input Variables ######################
########################################################
variable "app_name" { default = "WebServer" }

variable "aws_region" { default =  "ap-northeast-1" }

variable "instance_type" { default = "t2.micro" }

variable "instance_count" { default =  2 }

variable "root_block_device" {
  default = [{
      "volume_size" = 25
      "volume_type" = "gp3"
  }]
}