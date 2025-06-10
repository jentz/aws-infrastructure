variable "name_prefix" {
  description = "Base name for the S3 bucket. A random suffix will be added."
  type        = string
}

variable "versioning" {
  description = "Enable S3 bucket versioning"
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Force bucket deletion even if it contains objects"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to the bucket"
  type        = map(string)
  default     = {}
}
