
variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
  type        = string
}

variable "my_ip" {
  description = "Your IP address"
  type        = string
}

