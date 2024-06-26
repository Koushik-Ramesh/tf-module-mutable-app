# Creates Security Group
resource "aws_security_group" "allows_app" {
    name = "Roboshop-${var.COMPONENT}-${var.ENV}"
    description = "Roboshop-${var.COMPONENT}-${var.ENV}"
    vpc_id = data.terraform_remote_state.vpc.outputs.VPC_ID

 
    ingress {
        description = "SSH "
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    ingress {
        description = "Allow APP only traffic "
        from_port = var.APP_PORT
        to_port = var.APP_PORT
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    ingress {
        description = "Node Exporter Port"
        from_port = 9100
        to_port = 9100
        protocol = "tcp"
        cidr_blocks = [data.terraform_remote_state.vpc.outputs.VPC_CIDR, data.terraform_remote_state.vpc.outputs.DEFAULT_VPC_CIDR]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "Roboshop-${var.COMPONENT}-${var.ENV}"
    }
}
