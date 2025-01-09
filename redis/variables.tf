variable vpc_id {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "environment" {
  type = string
}

variable "project_name" {
  type = string
}

variable "cluster_name" {
  type = string
}