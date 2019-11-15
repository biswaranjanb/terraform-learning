provider "aws" {
    region ="us-east-2"  
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
  default     = 8080
}

resource "aws_instance" "example" {
  ami ="ami-0d5d9d301c853a04a"
  instance_type="t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Welcome. Example of a configurable server." > index.html
                nohup busybox httpd -f -p "${var.server_port}" &
                EOF

  tags = {
      Name="brb-terraform-configurable-server"
  }
}

resource "aws_security_group" "instance" {
  name = "brb-terraform-configurable-server"
  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP of the web server"
}