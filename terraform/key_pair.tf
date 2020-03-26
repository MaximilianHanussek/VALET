resource "tls_private_key" "internal_connection_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "openstack_compute_keypair_v2" "my-cloud-key" {
  name       = "vuc_internal_key"
  public_key = "${tls_private_key.internal_connection_key.public_key_openssh}"
}
