variable "region" {
  type    = string
}


variable "environment" {
  type    = string
}

variable "bucket" {
  type    = string
}

variable "dynamodb_table" {
  description ="The name of the dynamoDB table used to lock the state"  
  type    = string
}

variable "key" {
  type    = string
}

variable "encrypt" {
  type    = bool
}

variable "acl" {
  type    = string
  default = "private"
} 

