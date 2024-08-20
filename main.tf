
resource "aws_vpc" "abc_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy = "default"

  tags = {
    Name = "ABC Enterprise - VPC01",
    IaaCProvider = "terraform"
    Environment = "dev"
    Owner = "Elmer Marquez"
  }

}

resource "aws_subnet" "abc_vpc_public_subnet1" {
  vpc_id = aws_vpc.abc_vpc.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "ABC Enterprise - VPC01 - Public Subnet 1",
    IaaCProvider = "terraform"
    Environment = "dev"
    Owner = "Elmer Marquez"
  }
}

resource "aws_subnet" "abc_vpc_public_subnet2" {
  vpc_id = aws_vpc.abc_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "ABC Enterprise - VPC01 - Public Subnet 2",
    IaaCProvider = "terraform"
    Environment = "dev"
    Owner = "Elmer Marquez"
  }
}

resource "aws_internet_gateway" "abc_vpc_igw" {
  vpc_id = aws_vpc.abc_vpc.id

  tags = {
    Name = "ABC Enterprise - VPC01 - Internet Gateway",
    IaaCProvider = "terraform"
    Environment = "dev"
    Owner = "Elmer Marquez"
  }
  
}

resource "aws_route_table" "abc_vpc_public_route_table" {
    vpc_id = aws_vpc.abc_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.abc_vpc_igw.id
    }
  
    tags = {
        Name = "ABC Enterprise - VPC01 - Public Route Table",
        IaaCProvider = "terraform"
        Environment = "dev"
        Owner = "Elmer Marquez"
    }
}

resource "aws_route_table_association" "abc_vpc_public_subnet1_association" {
    subnet_id = aws_subnet.abc_vpc_public_subnet1.id
    route_table_id = aws_route_table.abc_vpc_public_route_table.id
}

resource "aws_route_table_association" "abc_vpc_public_subnet2_association" {
    subnet_id = aws_subnet.abc_vpc_public_subnet2.id
    route_table_id = aws_route_table.abc_vpc_public_route_table.id
}

resource "aws_security_group" "abc_vpc_sg_linux_with_ssh_http_s" {
    vpc_id = aws_vpc.abc_vpc.id
    name = "ABC Enterprise - VPC01 - SG01"
    description = "Security Group for Linux instances with SSH and HTTP access"
    tags = {
        Name = "ABC Enterprise - VPC01 - SG01",
        IaaCProvider = "terraform"
        Environment = "dev"
        Owner = "Elmer Marquez"
    }
}

resource "aws_vpc_security_group_ingress_rule" "abc_vpc_sgrule_allow_ssh" {
    security_group_id = aws_security_group.abc_vpc_sg_linux_with_ssh_http_s.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "abc_vpc_sgrule_allow_http" {
    security_group_id = aws_security_group.abc_vpc_sg_linux_with_ssh_http_s.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 80
    to_port = 80
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "abc_vpc_sgrule_allow_https" {
    security_group_id = aws_security_group.abc_vpc_sg_linux_with_ssh_http_s.id
    cidr_ipv4 = "0.0.0.0/0"
    from_port = 443
    to_port = 443
    ip_protocol = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "vpc1_sg1_er_allow_all_traffic_ipv4" {
    security_group_id = aws_security_group.abc_vpc_sg_linux_with_ssh_http_s.id
    cidr_ipv4         = "0.0.0.0/0"
    ip_protocol       = "-1" # semantically equivalent to all ports
}