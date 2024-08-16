# VPC Configuration Variables
variable "vpc_name" {
  description = "The name of the Virtual Private Cloud (VPC)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the Virtual Private Cloud (VPC)"
  type        = string
}

# Public Subnet Configuration
variable "publicsubnet_1_cidr" {
  description = "CIDR block for the first public subnet"
  type        = string
}

variable "publicsubnet_2_cidr" {
  description = "CIDR block for the second public subnet"
  type        = string
}

# Private Subnet Configuration
variable "privatesubnet_1_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
}

variable "privatesubnet_2_cidr" {
  description = "CIDR block for the second private subnet"
  type        = string
}

# Availability Zone Configuration
variable "availability_zone_1" {
  description = "Availability zone for the first set of subnets"
  type        = string
}

variable "availability_zone_2" {
  description = "Availability zone for the second set of subnets"
  type        = string
}
