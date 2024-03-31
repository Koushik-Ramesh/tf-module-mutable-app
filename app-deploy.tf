# Installing the application
resource "null_resource" "app" {
    count = local.INSTANCE_COUNT
  provisioner "remote-exec" {
      connection {
        type     = "ssh"
        user     = local.SSH_USERNAME
        password = local.SSH_PASSWORD
        host     = element(local_INSTANCE_PRIVATE_IPS, count.index)
    }
        inline = [
            "ansible-pull -U https://github.com/Koushik-Ramesh/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} roboshop-pull.yml"
        ]
    }
}
       

