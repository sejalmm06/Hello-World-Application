provider "aws" {
  region = ".ap-south-1" 
}

resource "aws_instance" "test_server" {
  ami           = "ami-0a7cf821b91bcccbc" 
  instance_type = "t2.micro"
  key_name      = "devopslab" 

  tags = {
    Name = "test-server"
  }
}

resource "aws_instance" "k8s_master" {
  ami           = "ami-0a7cf821b91bcccbc" 
  instance_type = "t2.medium"
  key_name      = "devopslab"

  tags = {
    Name = "k8s-master"
  }
}

resource "aws_instance" "k8s_worker" {
  ami           = "ami-0a7cf821b91bcccbc" 
  instance_type = "t2.micro"
  key_name      = "devopslab"  

  tags = {
    Name = "k8s-worker"
  }
}

# Output the public IP addresses of the instances
output "test_server_ip" {
  value = aws_instance.test_server.public_ip
}

output "k8s_master_ip" {
  value = aws_instance.k8s_master.public_ip
}

output "k8s_worker_ip" {
  value = aws_instance.k8s_worker.public_ip
}
