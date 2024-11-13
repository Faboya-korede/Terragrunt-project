variable "vpc_id" {
    type = string
}

variable "public_subnets" {
  type = list(string)
}


variable "name" {
type = string
}


variable "tags" {
  description = "A map of tags to add to all resources"
  default     = {}
}
