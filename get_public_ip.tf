data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}
resource "aws_security_group" "allow_web" {
  name   = "allow_web"
  vpc_id = aws_vpc.vpc.id
  ingress {
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    description = "Allow Web"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  }

  ingress {
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    description = "Allow Web HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
