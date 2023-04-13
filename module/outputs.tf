
output "load_balancer_dns" {
  value = aws_lb.lb.dns_name
}