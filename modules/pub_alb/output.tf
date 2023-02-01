output "dns_name" {
  description = "DNS of ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_arn" {
  value = aws_lb.alb.arn
}
output "bucket_arn" {
  value = aws_s3_bucket.log.arn
}

output "alb_http_listener_arn" {
  value = aws_alb_listener.alb_listener.arn
}

output "alb_https_listener_arn" {
  value = aws_alb_listener.alb_listener1.arn
}