#create launch config and auto scaling for webservers
resource "aws_launch_configuration" "launch_conf" {
  name_prefix   = "bg_lc_"
  image_id      = "ami-0ab7944c6328200be"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  security_groups = [
    "${aws_security_group.Webservers.id}",
  ]

  user_data = "${file("files/bootstrap.sh")}"

  lifecycle {
    create_before_destroy = true
  }
}

#create autoscaling group
resource "aws_autoscaling_group" "bg_asg" {
  name                 = "asg_${aws_launch_configuration.launch_conf.name}"
  max_size             = 3
  min_size             = 2
  min_elb_capacity     = 2
  launch_configuration = "${aws_launch_configuration.launch_conf.id}"
  load_balancers  = ["${aws_elb.terra-elb.id}"]  
  health_check_type    = "EC2"
  termination_policies = ["OldestLaunchConfiguration"]
  vpc_zone_identifier  = ["${aws_subnet.terra_public.*.id}"]

  lifecycle {
    create_before_destroy = true
  }
}
