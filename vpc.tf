#Vpc create 
resource "aws_vpc" "terra_vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags {
        Name = "terra_vpc"
    }
  
} 
# Create Internet Gateway and attach with vpc
resource "aws_internet_gateway" "terra_gw" {
    vpc_id = "${aws_vpc.terra_vpc.id}"
    tags {
        Name = "Main"
    }
  }
#Create Subnets for VPC
resource "aws_subnet" "terra_public" {
    count = "${length(var.subnet_cidr)}"
    vpc_id = "${aws_vpc.terra_vpc.id}"
    availability_zone = "${element(var.azs, count.index)}"
    cidr_block = "${element(var.subnet_cidr, count.index)}"

    tags{
        Name = "subnet-${count.index +1}"
    }
 }
#Create Route Table and assign with public subnet
resource "aws_route_table" "public_rt" {
    vpc_id = "${aws_vpc.terra_vpc.id}"

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.terra_gw.id}"

    }

    tags {
        Name = "Public Route"
    }
  }
# attach route table with public subnet
resource "aws_route_table_association" "a" {
    count = "${length(var.subnet_cidr)}"
    subnet_id = "${element(aws_subnet.terra_public.*.id, count.index)}"
    route_table_id = "${aws_route_table.public_rt.id}"
      
}
