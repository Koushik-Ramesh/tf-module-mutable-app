# Reads the information from the remote state file
data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "koushik-bucket"
        key = "vpc/${var.ENV}/terraform.tfstate"
        region = "us-east-1"

    }
}

# Reads the information from the remote ALB state file
data "terraform_remote_state" "alb" {
    backend = "s3"
    config = {
        bucket = "koushik-bucket"
        key = "alb/${var.ENV}/terraform.tfstate"
        region = "us-east-1"

    }
}
# Creates a lister and attaches to the laod balancer

resource "aws_lb_listener" "private" {
    count               = var.INTERNAL ? 1 : 0        
    load_balancer_arn   = var.INTERNAL ?1 : 0
    port                = "80"
    protocol            = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}