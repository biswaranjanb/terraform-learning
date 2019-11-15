provider "aws" {
    region = "us-east-1"  
}

resource "aws_instance" "example" {    
    ami = "ami-0d5d9d301c853a04a"    
    instance_type ="t2.micro"
    
    provisioner "local-exec" {
        command = "echo ${aws_instance.example.public_ip} > ip_address.txt"
    } 
    tags ={
        name="brb-terraform-provisioner"
    }
}

