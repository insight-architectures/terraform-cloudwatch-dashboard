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
        {size = 6},
        {size = 9},
        {size = 5},
        {size = 4}
    ]
}

resource "aws_s3_bucket" "this" {
    bucket_prefix = "test"
}

resource "aws_cloudwatch_dashboard" "this" {
    dashboard_name = "test-dashboard"
    dashboard_body = jsonencode({
        widgets = [
            module.first_widget.widget,
            module.second_widget.widget,
            module.third_widget.widget,
        ]
    })
}

module "first_widget" {
    source = "../../modules/widget"
    title = "Number of objects"
    columns = local.columns
    column = 1
    height = 3
    type = "metric"
    region = var.region
    view = "singleValue"
    metrics = [
        [ "AWS/S3", "NumberOfObjects", "StorageType", "AllStorageTypes", "BucketName", aws_s3_bucket.this.bucket ],
    ]
    properties = {
        sparkline = false
    }
}

module "second_widget" {
    source = "../../modules/widget"
    title = "Number of objects"
    columns = local.columns
    column = 2
    height = 3
    type = "metric"
    region = var.region
    view = "singleValue"
    metrics = [
        [ "AWS/S3", "NumberOfObjects", "StorageType", "AllStorageTypes", "BucketName", aws_s3_bucket.this.bucket ],
    ]
    properties = {
        sparkline = false
    }
}

module "third_widget" {
    source = "../../modules/widget"
    title = "Number of objects"
    columns = local.columns
    column = 3
    height = 3
    type = "metric"
    region = var.region
    view = "singleValue"
    metrics = [
        [ "AWS/S3", "NumberOfObjects", "StorageType", "AllStorageTypes", "BucketName", aws_s3_bucket.this.bucket ],
    ]
    properties = {
        sparkline = false
    }
}
