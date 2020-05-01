provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "firstinstance" {
    ami                     = "ami-085925f297f89fce1"
    instance_type           = "t2.micro"
    vpc_security_group_ids  = [aws_security_group.instance_sg.id]

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

// an expression in TF is anything that returns a value: literals and numbers for example
// reference access the values from other parts of the code
// resource attribute reference PROVIDER_TYPE.NAME.ATTRIBUTE: aws_security_group.instance_sg.id