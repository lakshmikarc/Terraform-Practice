variable "access_key" {}
variable "secret_key" {}
variable "aws_region" {
  default ="eu-west-1"
}


variable "instance_type" {
  default = "t2.micro"
  }
variable "key_name" {
  default = "VideoBurst-Pair"
}

variable "ami" {
  type = "map"

  default = {
    eu-west-1 = "ami-0ab7944c6328200be"
    eu-central-1 = "ami-034fffcc6a0063961"
  }

}
variable "subnet_cidr" {
  type = "list"
  default = ["192.168.3.0/24","192.168.4.0/24"]
  }
variable "vpc_cidr" {
  default = "192.168.0.0/16"
  
}
variable "azs" {
  type = "list"
  default = ["eu-west-1a","eu-west-1b"]
  }


