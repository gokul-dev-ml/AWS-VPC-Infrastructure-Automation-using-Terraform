
#ec2 instance
resource "aws_instance" "ec21" {
 ami = "resolve:ssm:/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.sg1.id]
  associate_public_ip_address = true
  key_name = "singaporekey"



  tags = {
    Name = "${var.client_id}_ec2_instance1"
    managed_by = var.managed_by
  }
}
#db
resource "aws_instance" "db1" {
  ami = "resolve:ssm:/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private_subnet1.id
  vpc_security_group_ids = [aws_security_group.sg1.id]
  associate_public_ip_address = false
  key_name = "singaporekey"



  tags = {
    Name = "${var.client_id}_db_instance1"
    managed_by = var.managed_by
  }
}
