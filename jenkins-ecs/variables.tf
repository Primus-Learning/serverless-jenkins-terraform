# Prefix for naming resources
variable "prefix" {
  type        = string
  description = "A prefix to be used in naming resources for better organization."
}

# List of private subnet IDs
variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnet IDs for the infrastructure."
}

# List of public subnet IDs
variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnet IDs for the infrastructure."
}

# ID of the VPC
variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the resources will be deployed."
}

# Port used by the Jenkins controller
variable "jenkins_controller_port" {
  type        = string
  description = "The port number used by the Jenkins controller for communication."
}

# Port used by Jenkins agents
variable "jenkins_agent_port" {
  type        = string
  description = "The port number used by Jenkins agents for communication with the controller."
}

# AWS region where the infrastructure will be deployed
variable "aws_region" {
  type        = string
  description = "The AWS region where the infrastructure will be deployed (e.g., us-east-1)."
}

# CPU configuration for the Jenkins controller
variable "jenkins_controller_cpu" {
  description = "The CPU configuration for the Jenkins controller, specified as needed for the environment."
}

# Memory configuration for the Jenkins controller
variable "jenkins_controller_mem" {
  description = "The memory configuration for the Jenkins controller, specified as needed for the environment."
}