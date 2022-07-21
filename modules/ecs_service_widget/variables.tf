variable "y" {
    type = number
    default = 0
}

variable "columns" {
    type = list(object({
        size = number
    }))
    default = [{size=24}]
    validation {
      condition = sum(flatten([for c in var.columns : [c.size]])) <= 24
      error_message = "The total width must be less or equal than 24."
    }
}

variable "column" {
    default = 1
    type = number
}

variable "height" {
    type = number
}

variable "region" {
    type = string
}

variable "properties" {
    type = object({})
    default = {}
}

variable "title" {
    type = string
}

variable "services" {
    type = list(object({
        service_name = string
        cluster_name = string
    }))
}

variable "metric" {
    type = string
    validation {
      condition = contains(["cpu", "memory", "task_count"], var.metric)
      error_message = "Accepted values: 'cpu', 'memory', 'task_count'."
    }
}