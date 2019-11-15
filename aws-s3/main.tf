provider "aws" {
    region="us-east-1"  
}

resource "aws_s3_bucket" "example" {
    bucket = "brb-terraform-s3-bucket"
    acl = "private"
}

resource "aws_instance" "example" {
    ami = "ami-0d5d9d301c853a04a"
    instance_type ="t2.micro"


    # depends on tells that EC2 instance must be created only after S3 bucket has been created.
    depends_on= [aws_s3_bucket.example]
  
}

