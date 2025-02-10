output "elb_dns_name" {
  description = "ELB DNS Name"
  value = aws_lb.application_load_balancer.dns_name
}