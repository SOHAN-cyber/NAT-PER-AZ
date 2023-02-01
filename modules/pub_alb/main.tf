data "aws_elb_service_account" "main" {
}

resource "aws_lb" "alb" {
  name                       = var.alb_name
  internal                   = var.internal
  load_balancer_type         = "application"
  security_groups            = var.security_groups_id
  subnets                    = var.subnets_id
  enable_deletion_protection = var.enable_deletion_protection

  tags = merge(
    {
      "Name" = format("%s-alb", var.alb_name)
    },
    var.tags,
  )

  access_logs {
    bucket  = aws_s3_bucket.log.id
    prefix  = format("%s-alb", var.alb_name)
    enabled = var.enable_logging
  }
}

resource "aws_s3_bucket" "log" {
  bucket        = var.lb_log_bucket_name
  force_destroy = var.force_destroy
}

resource "aws_s3_bucket_acl" "lb_logs" {
  bucket = aws_s3_bucket.log.id
  acl    = var.acl_type
}

resource "aws_s3_bucket_policy" "logs_policy" {
  bucket = aws_s3_bucket.log.id
  policy = aws_s3_bucket_policy.allow_elb_logging.policy
}

resource "aws_s3_bucket_policy" "allow_elb_logging" {
  bucket = aws_s3_bucket.log.id
  policy = <<POLICY
{
  "Id": "Policy",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.log.arn}/*",
      "Principal": {
        "AWS": [
          "${data.aws_elb_service_account.main.arn}"
        ]
      }
    }
  ]
}
POLICY
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "alb_listener1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 443
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
