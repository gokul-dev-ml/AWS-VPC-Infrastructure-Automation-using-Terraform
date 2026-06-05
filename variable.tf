variable "client_id" {
  description = "The client ID for the application."
  type        = string
  default     = "my-default"
}

variable "managed_by" {
  description = "The entity that manages the resource."
  type        = string
  default     = "terraform"
}
