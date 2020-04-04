
variable "instance_name" {
  description = "The name of the IAM Role."
}

variable "bucketname" {
  description = "The name of S3 bucket"
}

variable "kmskey" {
  description = "The name of kms key to encrypt S3 bucket"
}

variable "sourcevpcendpoint" {
  description = "The name of vpc endpoint"
}


variable "vpcid" {
  description = "The name of vpc id"
}







##################

variable "role_name" {
  description = "The name of the role. It will forces new resource on change."
  type        = "string"
}

variable "role_description" {
  description = "The description of the role being created. This will not force a change."
  type        = "string"
}

variable "role_path" {
  description = "Role path you would like to setup for this role"
  type        = "string"
  default     = "/"
}

variable "identifier_type" {
  description = "The list of services that need trust relationship with this role.Note: Region is hardcoded in default value"
  type        = "string"
  default     = "Service"
}
variable "identifier_names" {
  description = "The list of services that need trust relationship with this role.Note: Region is hardcoded in default value"
  type        = "list"
  default     = ["ec2.amazonaws.com"]
}
variable "app_role_tags" {
  description = "The list of tags to be placed on the role"
  type        = "map"
  default     = {}
}

