variable "vpc_id" {
    type = string
}

variable "pub_subnets" {
    type = list
}

variable "priv_subnets" {
    type = list
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "ubuntu_owner" {
    type = string
    default = "099720109477"
}

variable "ubuntu_filter" {
    type = string
    default = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
}

variable "key_name" {
    type = string
    default = "aws-iti-lab"
}

variable "ubuntu_user" {
    type = string
    default = "ubuntu"
}