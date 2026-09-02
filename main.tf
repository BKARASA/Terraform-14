#vpc
resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc-cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags={
    Name= "vpc-resume-app"
    env= "dev"
    Team= "devops"
  }
}
// internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "IGW"
  }
} 
#public subnet

resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch = true
  tags = {
    Name = "public-1a"
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.2.0/24"
availability_zone = "us-east-1b"
map_public_ip_on_launch = true
  tags = {
    Name = "public-1b"
  }
}
#Private subnets

resource "aws_subnet" "sub3" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.3.0/24"
availability_zone = "us-east-1a"
  tags = {
    Name = "private-1a"
  }
}
resource "aws_subnet" "sub4" {
  vpc_id     = aws_vpc.vpc1.id
  cidr_block = "10.0.4.0/24"
availability_zone = "us-east-1b"
  tags = {
    Name = "private-1b"
  }
}
# Nat gateway
resource "aws_nat_gateway" "Nat1" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.sub1.id
  tags = {
    Name = "gw NAT"
    }
  }

  // Elastic IP for Nat gateway
  resource "aws_eip" "eip"  {

   }

#Create Route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "public-route-table"
  }
}

# 2. Define a Standalone Route (Recommended over In-line)
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# 3. Associate the Route Table with a Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.public_rt.id
}

# Route and association for private subnets
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "private-route-table"
  }
}

# 2. Define a Standalone Route (Recommended over In-line)
resource "aws_route" "private_internet_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             =aws_nat_gateway.Nat1.id
}

# 3. Associate the Route Table with a Subnet
resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_assoc2" {
  subnet_id      = aws_subnet.sub4.id
  route_table_id = aws_route_table.private_rt.id

}


/*
resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.selected.id
  name    = "terraform.brennclnx.best "
  type    = "A"
  ttl     = 300
  records = ["200.10.19.34"]
}
*/


