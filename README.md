# Terraform CloudWatch Dashboard Modules

This repository contains a series of Terraform modules that can be used to populate a dashboard built with AWS CloudWatch.

The modules of this repository are built around the concept of _columns_. This allows for a quicker and easier placement of the widgets over the canvas.

## Getting started

First of all, we need to define the columns that we will be using in our dashboard.

```terraform
locals {
    columns = [
        {size = 6},
        {size = 9},
        {size = 5},
        {size = 4}
    ]
}

# The sum should not exceed 24
```

Then, we can use this repository to create a simple widget

```terraform
module "my_first_widget" {
    source = "https://github.com/insight-architectures/terraform-cloudwatch-dashboard//modules/widget"
    title = "Number of objects"
    columns = local.columns
    column = 1
    height = 3
    type = "metric"
    region = "eu-north-1"
    view = "singleValue"
    metrics = [
        [ "AWS/S3", "NumberOfObjects", "StorageType", "AllStorageTypes", "BucketName", "my_sample_bucket" ],
    ]
    properties = {
        sparkline = false
    }
}
```

Finally, we attach our widget to a `aws_cloudwatch_dashboard`.

```terraform
resource "aws_cloudwatch_dashboard" "sample" {
    dashboard_name = "sample"
    dashboard_body = jsonencode({
        widgets = [
            module.my_first_widget.widget
        ]
    })
}
```
