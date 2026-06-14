variable "alert_email" {
  description = "Email address that receives cloud monitoring alerts"
  type        = string
}

variable "visitor_counter_function_name" {
  description = "Name of the Lambda visitor-counter function"
  type        = string
  default     = "visitorCounterFunction"
}

resource "aws_sns_topic" "cloud_portfolio_alerts" {
  name = "cloud-portfolio-alerts-terraform"

  tags = {
    Project     = "CloudPortfolio"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_sns_topic_subscription" "email_alerts" {
  topic_arn = aws_sns_topic.cloud_portfolio_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "lambda_errors" {
  alarm_name          = "VisitorCounter-Lambda-Errors-Terraform"
  alarm_description   = "Alerts when the visitor-counter Lambda records an error."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 0
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 300
  statistic           = "Sum"
  treat_missing_data  = "notBreaching"
}

variable "cloudfront_distribution_id" {
  description = "CloudFront distribution ID for the portfolio site"
  type        = string
}

resource "aws_cloudwatch_metric_alarm" "cloudfront_5xx_errors" {
  alarm_name          = "CloudPortfolio-CloudFront-5XX-Terraform"
  alarm_description   = "Alerts when CloudFront 5XX error rate exceeds 1%."
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  threshold           = 1
  metric_name         = "5xxErrorRate"
  namespace           = "AWS/CloudFront"
  period              = 300
  statistic           = "Average"
  treat_missing_data  = "notBreaching"

  dimensions = {
    DistributionId = var.cloudfront_distribution_id
    Region         = "Global"
  }

  alarm_actions = [
    aws_sns_topic.cloud_portfolio_alerts.arn
  ]

  ok_actions = [
    aws_sns_topic.cloud_portfolio_alerts.arn
  ]

  tags = {
    Project   = "CloudPortfolio"
    ManagedBy = "Terraform"
  }
}

resource "aws_cloudwatch_dashboard" "cloud_portfolio_monitoring" {
  dashboard_name = "CloudPortfolioMonitoring-Terraform"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/Lambda", "Invocations", "FunctionName", var.visitor_counter_function_name],
            [".", "Errors", ".", "."],
            [".", "Duration", ".", "."],
            [".", "Throttles", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Lambda Visitor Counter Metrics"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/CloudFront", "Requests", "DistributionId", var.cloudfront_distribution_id, "Region", "Global"],
            [".", "4xxErrorRate", ".", ".", ".", "."],
            [".", "5xxErrorRate", ".", ".", ".", "."],
            [".", "BytesDownloaded", ".", ".", ".", "."]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "CloudFront Website Delivery Metrics"
          period  = 300
        }
      }
    ]
  })
}

