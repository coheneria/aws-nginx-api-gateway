# Assign region to variable
variable "region" {
  default     = "us-east-1"
  description = "AWS deafult region"
}

# Assign region to AMI
variable "AMI" {
default = "ami-0be07d6075940f84d"
}