#!/bin/sh

echo "Pre-Build Steps:"
echo "authenticating with AWS ECR..."
aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS --password-stdin 167390620396.dkr.ecr.ap-southeast-1.amazonaws.com

echo "Build Steps:"
echo "building image..."
docker build -t 167390620396.dkr.ecr.ap-southeast-1.amazonaws.com/react-ghub-aws:latest .

echo "Post-Build Steps:"
echo "pushing image to AWS ECR..."

docker push 167390620396.dkr.ecr.ap-southeast-1.amazonaws.com/react-ghub-aws:latest

echo "Updating AWS ECS Service..."
aws ecs update-service --cluster react-ghub-aws-cluster --service react-ghub-aws-sv --force-new-deployment

echo "Done!"