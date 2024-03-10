#!/bin/bash

IMAGE_TYPE=$1
AWS_REGION=$2
REPO_ENDPOINT=$3
MODULE_PATH=$4
REPOSITORY_URL=$5
SECRET_NAME="jenkins-controller-secrets"  # Replace with your actual secret name

echo "--- JENKINS $IMAGE_TYPE ---"

# Fetch the Jenkins controller username and password from AWS Secrets Manager
SECRET_JSON=$(aws secretsmanager get-secret-value --region $AWS_REGION --secret-id $SECRET_NAME | jq -r '.SecretString | fromjson')

# Extract the Jenkins controller username and password
JENKINS_CONTROLLER_USER=$(echo $SECRET_JSON | jq -r '.JENKINS_USER')
JENKINS_CONTROLLER_PASS=$(echo $SECRET_JSON | jq -r '.JENKINS_PASS')

# Log in to AWS ECR
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $REPO_ENDPOINT

# Build the Docker image for the controller with build arguments for Jenkins username and password
if [ "$IMAGE_TYPE" == "controller" ]; then
  docker build -t "jenkins-$IMAGE_TYPE" \
    --build-arg JENKINS_USER=$JENKINS_CONTROLLER_USER \
    --build-arg JENKINS_PASS=$JENKINS_CONTROLLER_PASS \
    $MODULE_PATH/../docker/jenkins_$IMAGE_TYPE --platform linux/amd64
else
  # Build the Docker image for other types without build arguments
  docker build -t "jenkins-$IMAGE_TYPE" $MODULE_PATH/../docker/jenkins_$IMAGE_TYPE --platform linux/amd64
fi

# Tag and push the Docker image
docker tag "jenkins-$IMAGE_TYPE:latest" "$REPOSITORY_URL:latest"
docker push "$REPOSITORY_URL:latest"