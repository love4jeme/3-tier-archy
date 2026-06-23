output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "asg_sg_id" {
  description = "Security group ID of the ASG EC2 instances"
  value       = aws_security_group.asg_sg.id
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.app.id
}
