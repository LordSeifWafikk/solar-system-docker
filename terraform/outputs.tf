output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.image_processing.bucket
}

output "sns_topic_arn" {
  description = "ARN of the SNS topic"
  value       = aws_sns_topic.image_processing.arn
}

output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.image_processing.url
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.image_processor.function_name
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.image_processing.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.image_processing.endpoint
}

output "eks_service_account_role_arn" {
  description = "ARN of the EKS service account IAM role"
  value       = aws_iam_role.eks_service_account_role.arn
}

