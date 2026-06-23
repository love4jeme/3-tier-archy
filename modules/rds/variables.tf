variable "project_name" {
  description = "Used to name and tag all resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "data_subnet_ids" {
  description = "IDs of the data subnets for RDS"
  type        = list(string)
}

variable "asg_sg_id" {
  description = "Security group ID of the ASG instances"
  type        = string
}

variable "db_username" {
  description = "RDS master username"
  type        = string
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "common_tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
}
