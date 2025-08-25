variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Base name for S3 bucket (will have random suffix appended)"
  type        = string
  default     = "image-processing-bucket"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "image-processing-cluster"
}

variable "alert_email" {
  description = "Email address for CloudWatch alerts"
  type        = string
  default     = "admin@example.com"
}

