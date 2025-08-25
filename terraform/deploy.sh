#!/bin/bash

set -e

echo "Starting deployment of image processing infrastructure..."

# Check if AWS CLI is configured
if ! aws sts get-caller-identity > /dev/null 2>&1; then
    echo "Error: AWS CLI is not configured. Please run 'aws configure' first."
    exit 1
fi

# Create Lambda deployment package
echo "Creating Lambda deployment package..."
cd ../lambda
zip -r ../terraform/lambda_function.zip index.js
cd ../terraform

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Plan deployment
echo "Planning Terraform deployment..."
terraform plan

# Apply deployment
echo "Applying Terraform deployment..."
terraform apply -auto-approve

# Get outputs
echo "Getting deployment outputs..."
BUCKET_NAME=$(terraform output -raw s3_bucket_name)
SQS_QUEUE_URL=$(terraform output -raw sqs_queue_url)
EKS_CLUSTER_NAME=$(terraform output -raw eks_cluster_name)
SERVICE_ACCOUNT_ROLE_ARN=$(terraform output -raw eks_service_account_role_arn)

echo "Deployment completed successfully!"
echo "S3 Bucket: $BUCKET_NAME"
echo "SQS Queue URL: $SQS_QUEUE_URL"
echo "EKS Cluster: $EKS_CLUSTER_NAME"
echo "Service Account Role ARN: $SERVICE_ACCOUNT_ROLE_ARN"

# Update kubeconfig
echo "Updating kubeconfig for EKS cluster..."
aws eks update-kubeconfig --region us-east-1 --name $EKS_CLUSTER_NAME

echo "Next steps:"
echo "1. Build and push Docker image to ECR"
echo "2. Update Kubernetes manifests with actual values"
echo "3. Deploy application to EKS cluster"

