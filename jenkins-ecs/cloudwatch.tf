# CloudWatch log group for Jenkins

resource "aws_cloudwatch_log_group" "jenkins_logs" {
  name = "/ecs/jenkins"

  tags = {
    Name = "${var.prefix}-logs"
  }
}

# log stream for the Jenkins controller
resource "aws_cloudwatch_log_stream" "jenkins_controller_log_stream" {
  name           = "jenkins-controller"
  log_group_name = aws_cloudwatch_log_group.jenkins_logs.name
}

# log stream for the Jenkins agents
resource "aws_cloudwatch_log_stream" "jenkins_agent_log_stream" {
  name           = "jenkins-agent"
  log_group_name = aws_cloudwatch_log_group.jenkins_logs.name
}