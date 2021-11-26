output "nginx_external_ip" {
  value = aws_eip.elastic_ip.public_ip
}

output "nginx_external_dns" {
  value = aws_eip.elastic_ip.public_dns
}