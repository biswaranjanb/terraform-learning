provider "aws" {
    region ="us-east-2"  
}

resource "aws_instance" "example" {
  ami ="ami-0d5d9d301c853a04a"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Welcome. Example of a Single Server" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

  tags = {
      Name="brb-terraform"
  }
}

resource "aws_security_group" "instance" {
  name = "brb-terraform"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# resource "aws_eip" "ip" {
#   vpc = true
#   instance = aws_instance.example.id  
# }

