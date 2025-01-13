variable "name" {
  type = string
}

variable "cluster_arn" {
  type = string
}

variable "apiImage" {
    type = string
}

variable "apiPort" {
    type = number
}

variable "container_name" {
    type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "namespace" {
    type = string
}

variable "task_role" {
  type = string
}

variable "create_task_exec_iam_role" {
  type = bool
}

variable "create_task_exec_policy" {
  type = bool
}

variable "create_tasks_iam_role" {
  type = bool
}

variable "vpc_id" {
  type = string
  
}

variable "target_group_arn" {
  type = string
}

variable "secrets" {
  type = map(string)
  default = {}
}

variable "nginxProxy" {
  type = bool
}

variable nginxImage {
    type = string
}