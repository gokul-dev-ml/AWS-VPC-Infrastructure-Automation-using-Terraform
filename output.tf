output "vpc_id" {
  value = aws_vpc.vpc1.id

}
output "public_subnet_id" {
  value = aws_subnet.public_subnet1.id

}
output "private_subnet_id" {
  value = aws_subnet.private_subnet1.id
}
output "ec2_instance_id" {
  value = aws_instance.ec21.id
}
output "db_instance_id" {
  value = aws_instance.db1.id
}
