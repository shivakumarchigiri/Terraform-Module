# Terraform AWS EC2 Module

This Terraform module provisions a complete AWS infrastructure to deploy an EC2 instance with a custom user data script. It includes VPC, Subnet, Internet Gateway, Route Table, Security Groups, Elastic IP, and Network Interface resources.

---

## Features

- Creates a **VPC** with customizable CIDR block and name
- Creates a **Subnet** with a custom CIDR block
- Creates and attaches an **Internet Gateway**
- Creates a **Route Table** and associates it with the subnet
- Defines a **Security Group** allowing SSH (22), HTTP (80), HTTPS (443), and all outbound traffic
- Creates a **Network Interface** with specified private IP(s) and security groups
- Allocates and associates an **Elastic IP** to the network interface
- Deploys an **EC2 instance** attached to the network interface with user-defined AMI, instance type, and SSH key
- Injects a **user data shell script** for EC2 bootstrap automation

---

## Usage

1. Clone or add this module as a source in your Terraform root project:

```hcl
module "ec2_module" {
  source = "git::https://github.com/shivakumarchigiri/Terraform-Module.git"

  vpc_cidr                  = "Vpc range"   //Example---# Terraform AWS EC2 Module

This Terraform module provisions a complete AWS infrastructure to deploy an EC2 instance with a custom user data script. It includes VPC, Subnet, Internet Gateway, Route Table, Security Groups, Elastic IP, and Network Interface resources.

---

## Features

- Creates a **VPC** with customizable CIDR block and name
- Creates a **Subnet** with a custom CIDR block
- Creates and attaches an **Internet Gateway**
- Creates a **Route Table** and associates it with the subnet
- Defines a **Security Group** allowing SSH (22), HTTP (80), HTTPS (443), and all outbound traffic
- Creates a **Network Interface** with specified private IP(s) and security groups
- Allocates and associates an **Elastic IP** to the network interface
- Deploys an **EC2 instance** attached to the network interface with user-defined AMI, instance type, and SSH key
- Injects a **user data shell script** for EC2 bootstrap automation

---

## Usage

1. Clone or add this module as a source in your Terraform root project:

```hcl
module "ec2_module" {
  source = "git::https://github.com/shivakumarchigiri/Terraform-Module.git"

  vpc_cidr                  = "{your_cidr_range}"         // Ex:10.0.0.0/16
  vpc_name                  = "{Your_VPC name}"           //Ex: prod-vpc
  subnet_cidr               = "{Your_subnet_cidr_range}"  //Ex: 10.0.1.0/24
  private_ips               = [{Your_Private_ip}]         //Ex: "10.0.1.10"
  associate_with_private_ip = {Your_private_ip}           //Ex: "10.0.1.10"
  ami                       = "{Your_ami}"                //Ex: ami-0c55b159cbfafe1f0
  instance_type             = "{Your_intance type}"       //Ex: t2.micro
  key_name                  = "my-ssh-key"
  instance_name             = "my-ec2-instance"
  user_data                 = file("${path.module}/scripts/myscript.sh")
}
