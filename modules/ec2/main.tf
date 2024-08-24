resource "aws_instance" "this" {
  ami           = "ami-0d07675d294f17973"
  instance_type = "t2.micro"
  subnet_id     = var.subnet_id
  associate_public_ip_address = false

  tags = {
    Name = "${var.name}-instance"
  }
}

output "instance_id" {
  value = aws_instance.this.id
}
