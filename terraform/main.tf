provider "aws" {
  region = "us-east-1"
  profile = "dev"
}

module "vpc" {
    source = "./modules/vpc"
}

module "ec2" {
    source = "./modules/ec2"
    vpc_id = module.vpc.vpc_id
    priv_subnets = module.vpc.priv_subnets
    pub_subnets = module.vpc.pub_subnets
}

module "eks" {
    source = "./modules/eks"
    cluster_name = var.cluster_name
    priv_subnets = module.vpc.priv_subnets
    bastion_host_private_ip = module.ec2.bastion_host_private_ip
    vpc_id = module.vpc.vpc_id
    ubuntu_ami_id = module.ec2.ubuntu_ami_id
}

resource "local_file" "output_file" {
    content = <<-EOF
    cluster_name=${module.eks.cluster_name}
    cluster_endpoint=${module.eks.endpoint}
    cluster_ca=${module.eks.kubeconfig-certificate-authority-data}
    bastion_host_ip=${module.ec2.bastion_host_ip}
    EOF
    filename = "../outputs.txt"
}