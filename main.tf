
module "vpc" {
  source = "./modules/vpc"
}

module "security_groups" {
  source             = "./modules/security_groups"
  vpc_id             = module.vpc.vpc_id
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  my_ip              = "102.91.93.138/32"
}

module "instances" {
  source             = "./modules/instances"
  public_subnet_id   = module.vpc.public_subnet_id
  private_subnet_id  = module.vpc.private_subnet_id
  public_sg_id       = module.security_groups.public_sg_id
  private_sg_id      = module.security_groups.private_sg_id
  key_name           = "KCKeyPair"
  nginx_script       = file("${path.module}/scripts/install_nginx.sh")
  postgresql_script  = file("${path.module}/scripts/install_postgresql.sh")
}
