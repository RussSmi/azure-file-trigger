variable "location" {
  type        = string
  description = "The location in which the deployment is happening"
  default     = "uksouth"
}

variable "loc" {
  type        = string
  description = "The location in which the deployment is happening - short form"
  default     = "uks"
}

variable "ident" {
  type        = string
  description = "The project identifier for resources"
  default     = "ftrig"
}

variable "instance" {
  type        = string
  description = "Instance no"
  default     = "001"
}

variable "rg" {
  type        = string
  description = "Resource Group Name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "external_storage_name" {
  type        = string
}




