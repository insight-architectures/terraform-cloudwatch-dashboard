locals {

    properties = {
        title = var.title
        metrics = var.metrics
        region = var.region
        view = var.view
    }

    sizes = flatten(concat([0],[for c in var.columns : [c.size]]))

    columns_x = slice([for idx, s in local.sizes : sum(slice(local.sizes, 0, idx + 1 ))], 0, length(var.columns))

    widget = {
        y = var.y
        x = local.columns_x[var.column -1]
        height = var.height
        width = local.sizes[var.column]
        type = var.type
        properties = merge(local.properties, var.properties)
    }

}