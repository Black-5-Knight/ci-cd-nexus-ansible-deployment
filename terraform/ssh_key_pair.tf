
resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "kp" {
  key_name   = "myKey"       # Create "myKey" to AWS!!
  public_key = tls_private_key.pk.public_key_openssh

  provisioner "local-exec" { # Create "myKey.pem" to your computer!!
    command = <<EOT
    echo '${tls_private_key.pk.private_key_pem}' >> myKey.pem
    chmod 400 myKey.pem
    EOT
  }
}