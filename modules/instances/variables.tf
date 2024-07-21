
variable "public_subnet_id" {
  description = "The ID of the public subnet"
  type        = string
}

variable "private_subnet_id" {
  description = "The ID of the private subnet"
  type        = string
}

variable "public_sg_id" {
  description = "The ID of the public security group"
  type        = string
}

variable "private_sg_id" {
  description = "The ID of the private security group"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}

variable "nginx_script" {
  description = "Script to install Nginx"
  type        = string
}

variable "postgresql_script" {
  description = "Script to install PostgreSQL"
  type        = string
}
