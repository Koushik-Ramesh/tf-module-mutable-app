# Creates App Component Record agaonst the ALB
resource "aws_route53_record" "docdb_dns" {
  zone_id = var.INTERNAL ? data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN : data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ARN
  name    = "${var.COMPONENT}-${var.ENV}"
  type    = "CNAME"
  ttl     = 10
  records = var.INTERNAL ? [ data.terraform_remote_state.alb.outputs.PRIVATE_ALB_ARN : data.terraform_remote_state.alb.outputs.PUBLIC_ALB_ARN ]
}