variable "awsregion"{
    type = string
    description = "This is the region"
}
variable "access_key"{
    type = string
    description = "Enter access key"
}
variable "secret_key"{
    type = string
    description = "Enter secret key"
}
variable "vpc_cidr_block"{
    type = string
    default = "This is main vpc cidr"
}
variable "vpc_name" {
  type = string
  description = "This is vpc name"
}
variable "dev_pub_cidr_block" {
  type = string 
  description = "This is publiv cidr block"
}
variable "dev_pvt_cidr_block" {
  type = string
  description = "This is pvt cidr block"
}
variable "dev_pub_subnet_name" {
  type = string
  description = "This is dev pub subnet name"
}
variable "dev_pvt_subnet_name" {
  type = string
  description = "This is dev pvt subnet name"
}
variable "public_ip_on" {
  type = bool
  description = "Assign public ip on"
}
variable "route_table_name" {
  type = string
  description = "Name of route table"
}
variable "internet_gateway_name" {
  type = string
  description = "Name of internet gateway"
}
variable "internetgateway_cidr" {
  type = string
  description = "cidr block of internetgate way to allow all trafficd"
}
variable "security_group_name" {
  type = string
  description = "enter security group name"
}
variable "Sercurity_group_ports" {
  type = list(number)
  description = "enter ports to add in security group "
}