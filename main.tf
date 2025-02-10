resource "aws_vpc" "hcl-vpc" {
  cidr_block = var.vpc_cidr
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "elb_subnet" {
  count = 2
  vpc_id = aws_vpc.hcl-vpc.id
  cidr_block = element(var.subnet_cidr, count.index)
  map_public_ip_on_launch = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.hcl-vpc.id
}

resource "aws_route_table" "main_route_table" {
  vpc_id = aws_vpc.hcl-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_igw.id
  }
}

resource "aws_route_table_association"  "public_subnet_association" {
  count = length(aws_subnet.elb_subnet)
  subnet_id = element(aws_subnet.elb_subnet.*.id, count.index)
  route_table_id = aws_route_table.main_route_table.id
}

resource "aws_security_group" "elb_sg" {
  vpc_id = aws_vpc.hcl-vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

resource "aws_instance" "web_instance" {
  count = var.instance_count
  ami = "ami-085ad6ae776d8f09c" # Amazon Linux 2023
  instance_type = var.instance_type
  subnet_id = element(aws_subnet.elb_subnet.*.id, count.index)
  security_groups = [ aws_security_group.elb_sg.id ]

  user_data = <<-EOF
    #!/bin/bash
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "Hello from instance ${count.index}" > /var/www/html/index.html
  EOF  
}

resource "aws_lb" "application_load_balancer" {
  name = "elb-lab-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [ aws_security_group.elb_sg.id ]
  subnets = aws_subnet.elb_subnet[*].id
}

resource "aws_lb_target_group" "elb_target_group" {
  name = "elb-lab-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.hcl-vpc.id
}

resource "aws_lb_listener" "elb_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.elb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "elb_target_attachment" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.elb_target_group.arn
  target_id = aws_instance.web_instance[count.index].id
  port = 80
}