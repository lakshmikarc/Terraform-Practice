# create Webservers 
resource "aws_instance" "webserver" {
    count = "${length(var.subnet_cidr)}"
    ami           = "${lookup(var.ami,var.aws_region)}"
    instance_type = "${var.instance_type}"
    key_name               = "${var.key_name}"
    security_groups = ["${aws_security_group.Webservers.id}"]
    subnet_id = "${element(aws_subnet.terra_public.*.id, count.index)}"
    user_data              = "${file("files/bootstrap.sh")}"

    tags {
        Name = "webserver-${count.index}"
    }

  
}
