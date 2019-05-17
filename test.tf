# Provider 
provider "aws" {
  access_key = "xxxxxxxxxxxxxx"
  secret_key =  "xxxxxxxxxxxxxxxxxxxxxxxxxxx"
  region	 = "xxxx"
}


# EC2
resource "aws_instance" "test" {
  ami           = "ami-bbc542c8"
  instance_type = "t2.micro"
  
  tags {
   Name = "myec2"
 }
