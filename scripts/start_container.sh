#!/bin/bash
set -e

# Load environment variables
AWS_ACCOUNT_ID=$(aws ssm get-parameter --name "/myapp/aws-account-id" --query "Parameter.Value" --output text)
AWS_REGION=$(aws ssm get-parameter --name "/myapp/aws-region" --query "Parameter.Value" --output text)
ECR_REPOSITORY_NAME=$(aws ssm get-parameter --name "/myapp/ecr-repository/name" --query "Parameter.Value" --output text)

REPOSITORY_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME"

# Assuming IMAGE_TAG is passed as an environment variable or set by CodePipeline
echo "Using Image Tag: $IMAGE_TAG"

# Logging in to Amazon ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPOSITORY_URI

# Pulling the image with the dynamic tag
echo "Pulling image from ECR with tag: $IMAGE_TAG..."
docker pull $REPOSITORY_URI:$IMAGE_TAG

# Starting the container
echo "Starting container..."
docker run -d -p 80:5173 --name online-shop-container $REPOSITORY_URI:$IMAGE_TAG
