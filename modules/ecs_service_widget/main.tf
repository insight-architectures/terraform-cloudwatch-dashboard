locals {
    metrics = {
        "cpu" = [for svc in var.services : ["AWS/ECS", "CPUUtilization", "ServiceName", svc.service_name, "ClusterName", svc.cluster_name]]

        "memory" = [for svc in var.services : ["AWS/ECS", "MemoryUtilization", "ServiceName", svc.service_name, "ClusterName", svc.cluster_name]]

        "task_count" = [for svc in var.services : ["ECS/ContainerInsights", "RunningTaskCount", "ServiceName", svc.service_name, "ClusterName", svc.cluster_name]]
    }
}


module "this" {
    source = "../widget"
    columns = var.columns
    column = var.column
    y = var.y
    height = var.height
    type = "metric"
    region = var.region
    view = "timeSeries"
    title = var.title
    properties = {
        stacked = false
        legend = { position = "right" }
        yAxis = {
            right = { showUnits = false }
            left = { showUnits = true, min = 0, max = 100 }
        }
        setPeriodToTimeRange = false
        stat = "Average"
        period = 300
    }
    metrics = local.metrics[var.metric]
}