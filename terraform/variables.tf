variable "cluster_name" {
    type = string
}
variable "vpc_cidr" {
    type = string
}
variable "subnets" {
    type = map
}
variable "instance_type" {
    type = string
}
variable "ami" {
    type = map
}