provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "firstinstance" {
    ami             = "ami-085925f297f89fce1"
    instance_type   = "t2.micro"

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello World!" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    tags = {
        Name = "First Instance"
    }
}

resource "aws_security_group" "instance_sg" {
    name        = "firstinstance_sg"

    ingress {
        from_port   = 8080
        to_port     = 8080
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

