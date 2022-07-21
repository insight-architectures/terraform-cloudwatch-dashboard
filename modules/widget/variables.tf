variable "y" {
    type = number
    default = 0
}

variable "columns" {
    type = list(object({
        size = number
    }))
}

variable "column" {
    type = number
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
}