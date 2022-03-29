########################################################
#################### Outputs ###########################
########################################################

output "fqdn" {
    value = aws_instance.webservers.*.private_dns
}

output "private_ip" {
    value = aws_instance.webservers.*.private_ip
}

output "instance_id" {
    value = aws_instance.webservers.*.id
}