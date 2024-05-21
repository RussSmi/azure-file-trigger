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

variable "storage_container_names" {
  type    = list(string)
  default = ["backend-api", "blob-trigger"]
}

variable "storage_fileshare_names" {
  type    = list(string)
  default = ["inbound", "archive", "to-blob"]
}


