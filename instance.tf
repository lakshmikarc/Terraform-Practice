# create instance using existing security group
resource "aws_instance" "test" {
  ami                    = "${lookup(var.ami,var.aws_region)}"
  count                  = 1
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name}"
  user_data              = "${file("files/bootstrap.sh")}"
  vpc_security_group_ids = ["sg-657f4702"]

  tags {
    Name = "Terraform"
    ENV  = "Dev"
  }
}

output "ip" {
  value = "${aws_instance.test.*.public_ip}"
}
