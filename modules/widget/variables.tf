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
    type = number
    default = 1
}

variable "height" {
    type = number
}

variable "type" {
    type = string
}

variable "metrics" {
    type = list(list(string))
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

variable  "view" {
    type = string
    validation {
      condition = contains(["timeSeries", "singleValue"], var.view)
      error_message = "Accepted values: 'timeSeries', 'singleValue'."
    }
}