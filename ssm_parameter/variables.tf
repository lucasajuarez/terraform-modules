variable "parameters" {
  description = "Map of variables"
  type = map(object({
    value = string
    type  = string
  }))
}