#!/bin/bash
set -e

# Load environment variables from AWS Parameter Store
AWS_ACCOUNT_ID=$(aws ssm get-parameter --name "/myapp/aws-account-id" --with-decryption --query "Parameter.Value" --output text)
AWS_REGION=$(aws ssm get-parameter --name "/myapp/aws-region" --with-decryption --query "Parameter.Value" --output text)
ECR_REPOSITORY_NAME=$(aws ssm get-parameter --name "/myapp/ecr-repository/name" --with-decryption --query "Parameter.Value" --output text)

REPOSITORY_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY_NAME"

# Load IMAGE_TAG from file
if [ -f "/home/ubuntu/online-shop-app/imageTag.txt" ]; then
  IMAGE_TAG=$(cat /home/ubuntu/online-shop-app/imageTag.txt)
else
  echo "Error: IMAGE_TAG file not found!"
  exit 1
fi

echo "Using Image Tag: $IMAGE_TAG"

# Logging in to Amazon ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$REPOSITORY_URI"

# Pulling the image from ECR
echo "Pulling image from ECR with tag: $IMAGE_TAG..."
docker pull "$REPOSITORY_URI:$IMAGE_TAG"

# Stop existing container if running
EXISTING_CONTAINER=$(docker ps -q --filter "name=online-shop-container")
if [ -n "$EXISTING_CONTAINER" ]; then
  echo "Stopping and removing existing container..."
  docker stop "$EXISTING_CONTAINER" && docker rm "$EXISTING_CONTAINER"
fi

# Starting new container
echo "Starting new container..."
docker run -d -p 80:5173 --name online-shop-container "$REPOSITORY_URI:$IMAGE_TAG"
