
# Creating the VPC 

resource "aws_vpc" "dev_vpc" {

    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
      Name=var.vpc_name
    }
  
}

#Creating the Internet gateway

resource "aws_internet_gateway" "dev_igw" {

  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-igw"
  }
  
}


#Creating the route table

resource "aws_route_table" "dev_rt" {
   vpc_id = aws_vpc.dev_vpc.id

   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_igw.id
   }

   tags = {
     Name= "dev_rt"
   }

}

#Creating the Subnet

resource "aws_subnet" "dev_subnet" {

  vpc_id = aws_vpc.dev_vpc.id

  cidr_block = var.subnet_cidr

  tags = {
    Name="dev_subnet"
  }
  
}

# Associate the Route table with the Subnet

resource "aws_route_table_association" "dev_rta" {

subnet_id = aws_subnet.dev_subnet.id
route_table_id = aws_route_table.dev_rt.id
  
}

resource "aws_security_group" "dev_sec_grp" {

  vpc_id = aws_vpc.dev_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol =  "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  description = "Security group"

  tags = {
    Name = "dev_sec_grp"
  }
  
}

#Creating the network interface

resource "aws_network_interface" "dev_nic" {

  subnet_id = aws_subnet.dev_subnet.id
  private_ips = var.private_ips
  security_groups = [aws_security_group.dev_sec_grp.id]

  tags = {
    Name = "dev_nic"
  }
  
}

#Creating Elastic IP

resource "aws_eip" "dev_eip" {
  domain = "vpc"
  network_interface = aws_network_interface.dev_nic.id
  associate_with_private_ip = var.associate_with_private_ip

  
}

resource "aws_instance" "dev_server" {

  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name

  user_data = file("myscript.sh")
  
  network_interface {
    network_interface_id = aws_network_interface.dev_nic.id
    device_index = 0
  }

  tags = {
    Name = var.instance_name
  }

}





