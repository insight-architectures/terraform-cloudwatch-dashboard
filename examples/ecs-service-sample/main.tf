provider "aws" {
    region = var.region
    profile = var.profile

    default_tags {
      tags = {
        "Project" = "CloudWatchDashboardModule"
        "Environment" = terraform.workspace
      }
    }
}

variable "region" {
    type = string
}

variable "profile" {
    type = string
    default = "default"
}

locals {
    columns = [
        {size = 2},
        {size = 20},
        {size = 2}
    ]

    services = [
        {service_name="my-first-service", cluster_name="my-cluster"},
        {service_name="my-second-service", cluster_name="my-cluster"},
        {service_name="my-third-service", cluster_name="my-cluster"},
    ]
}

resource "aws_cloudwatch_dashboard" "this" {
    dashboard_name = "test-dashboard"
    dashboard_body = jsonencode({
        widgets = [
            module.ecs_cpu_widget.widget,
            module.ecs_memory_widget.widget,
            module.ecs_task_count_widget.widget
        ]
    })
}

module "ecs_cpu_widget" {
    source = "../../modules/ecs_service_widget"
    title = "Services CPU utilization"
    height = 6
    region = var.region
    metric = "cpu"
    services = local.services
    columns = local.columns
    column = 2
}

module "ecs_memory_widget" {
    source = "../../modules/ecs_service_widget"
    title = "Services Memory utilization"
    height = 6
    region = var.region
    metric = "memory"
    services = local.services
    columns = local.columns
    column = 2
}

module "ecs_task_count_widget" {
    source = "../../modules/ecs_service_widget"
    title = "Running Tasks per service"
    height = 6
    region = var.region
    metric = "task_count"
    services = local.services
    columns = local.columns
    column = 2
}