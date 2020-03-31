resource "openstack_blockstorage_volume_v2" "beeond_volume_master" {
  name 		= "${var.name_prefix}beeond_volume_master"
  size 		= "${var.beeond_disk_size}"
  volume_type 	= "${var.beeond_storage_backend}"
}

resource "openstack_blockstorage_volume_v2" "beeond_volume_compute" {
  count         = "${var.compute_node_count}"
  name          = "${var.name_prefix}beeond_volume_compute-${count.index}"
  size          = "${var.beeond_disk_size}"
  volume_type   = "${var.beeond_storage_backend}"
}


resource "openstack_compute_instance_v2" "master-instance" {
  name            = "${var.name_prefix}master"
  flavor_name     = "${var.flavors["master"]}"
  image_id        = "${openstack_images_image_v2.vuc-image-master.id}"
  key_pair        = "${var.openstack_key_name}"
  security_groups = "${var.security_groups}"
  
  network {
    name = "${var.network_master}"
  }

  network {
    name = "${var.network_master_local}"
  }


block_device {
    uuid                  = "${openstack_images_image_v2.vuc-image-master.id}"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

block_device {
    uuid                  = "${openstack_blockstorage_volume_v2.beeond_volume_master.id}"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = -1
    delete_on_termination = true
  }

  provisioner "remote-exec" {
    script = "mount_cinder_volumes.sh"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host	  = "${self.access_ip_v4}"
    }
  }

   provisioner "remote-exec" {
    script = "configure_local_net.sh"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }


  provisioner "file" {
    content = "${tls_private_key.internal_connection_key.private_key_pem}"
    destination = "~/.ssh/connection_key.pem"  
  
    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  } 

  provisioner "remote-exec" {
    script = "set_internal_private_key_permissions.sh"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${openstack_compute_instance_v2.master-instance.access_ip_v4} ${var.name_prefix}master-public' >> /etc/hosts",
      "echo '${openstack_compute_instance_v2.master-instance.network.1.fixed_ip_v4} ${var.name_prefix}master' >> /etc/hosts",
      "echo '${openstack_compute_instance_v2.compute.0.access_ip_v4} ${var.name_prefix}compute-node-0' >> /etc/hosts",
      "echo '${openstack_compute_instance_v2.compute.1.access_ip_v4} ${var.name_prefix}compute-node-1' >> /etc/hosts"
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }
 
  provisioner "file" {
    source = "../beeond"
    destination = "/home/centos/beeond"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../beegfs-ondemand-stoplocal"
    destination = "/home/centos/beegfs-ondemand-stoplocal"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../configure_unicore"
    destination = "/home/centos/configure_unicore"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }
 
  provisioner "file" {
    source = "../start_initial_unicore_cluster"
    destination = "/home/centos/start_initial_unicore_cluster"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../add_node_to_cluster"
    destination = "/home/centos/add_node_to_cluster"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../add_node_to_torque"
    destination = "/home/centos/add_node_to_torque"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../add_to_host_file"
    destination = "/home/centos/add_to_host_file"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../update_unicore_resources"
    destination = "/home/centos/update_unicore_resources"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }


  provisioner "file" {
    source = "../beeond-add-storage-node"
    destination = "/home/centos/beeond-add-storage-node"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../remove_node_from_cluster"
    destination = "/home/centos/remove_node_from_cluster"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../delete_node_from_torque"
    destination = "/home/centos/delete_node_from_torque"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../delete_from_host_file"
    destination = "/home/centos/delete_from_host_file"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../beeond-remove-storage-node"
    destination = "/home/centos/beeond-remove-storage-node"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../setup_zabbix"
    destination = "/home/centos/setup_zabbix"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../zabbix_api.py"
    destination = "/home/centos/zabbix_api.py"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../zabbix.conf.php"
    destination = "/home/centos/zabbix.conf.php"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../delete_node_from_zabbix.py"
    destination = "/home/centos/delete_node_from_zabbix.py"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../VALET_scheduler.service"
    destination = "/home/centos/VALET_scheduler.service"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../VALET_scheduler.timer"
    destination = "/home/centos/VALET_scheduler.timer"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../virtual_cluster_scheduler"
    destination = "/home/centos/virtual_cluster_scheduler"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "file" {
    source = "../VALET_balancer_parser"
    destination = "/home/centos/VALET_balancer_parser"

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/centos/beeond /opt/beegfs/sbin/beeond",
      "sudo mv /home/centos/beegfs-ondemand-stoplocal /opt/beegfs//lib/beegfs-ondemand-stoplocal",
      "sudo mv /home/centos/configure_unicore /usr/local/bin/configure_unicore",
      "sudo mv /home/centos/start_initial_unicore_cluster /usr/local/bin/start_initial_unicore_cluster",
      "sudo mv /home/centos/add_node_to_cluster /usr/local/bin/add_node_to_cluster",
      "sudo mv /home/centos/add_node_to_torque /usr/local/bin/add_node_to_torque",
      "sudo mv /home/centos/add_to_host_file /usr/local/bin/add_to_host_file",
      "sudo mv /home/centos/update_unicore_resources //usr/local/bin/update_unicore_resources",
      "sudo mv /home/centos/beeond-add-storage-node /opt/beegfs/sbin/beeond-add-storage-node",
      "sudo mv /home/centos/remove_node_from_cluster /usr/local/bin/remove_node_from_cluster",
      "sudo mv /home/centos/delete_node_from_torque /usr/local/bin/delete_node_from_torque",
      "sudo mv /home/centos/delete_from_host_file /usr/local/bin/delete_from_host_file",
      "sudo mv /home/centos/beeond-remove-storage-node /opt/beegfs/sbin/beeond-remove-storage-node",     
      "sudo mv /home/centos/setup_zabbix /usr/local/bin/setup_zabbix",
      "sudo mv /home/centos/zabbix_api.py /usr/local/bin/zabbix_api.py",
      "sudo mv /home/centos/delete_node_from_zabbix.py /usr/local/bin/delete_node_from_zabbix.py",
      "sudo mv /home/centos/VALET_scheduler.service /usr/lib/systemd/system/VALET_scheduler.service",
      "sudo mv /home/centos/VALET_scheduler.timer /usr/lib/systemd/system/VALET_scheduler.timer",
      "sudo mv /home/centos/virtual_cluster_scheduler /usr/local/bin/virtual_cluster_scheduler",
      "sudo mv /home/centos/VALET_balancer_parser /usr/local/bin/VALET_balancer_parser",
      "sudo chmod 777 /opt/beegfs/sbin/beeond",
      "sudo chmod 777 /opt/beegfs/lib/beegfs-ondemand-stoplocal",
      "sudo chmod 777 /usr/local/bin/configure_unicore",
      "sudo chmod 777 /usr/local/bin/start_initial_unicore_cluster",
      "sudo chmod 777 /usr/local/bin/add_node_to_cluster",
      "sudo chmod 777 /usr/local/bin/add_node_to_torque",
      "sudo chmod 777 /usr/local/bin/add_to_host_file",
      "sudo chmod 777 /usr/local/bin/update_unicore_resources",
      "sudo chmod 777 /opt/beegfs/sbin/beeond-add-storage-node",
      "sudo chmod 777 /usr/local/bin/remove_node_from_cluster",
      "sudo chmod 777 /usr/local/bin/delete_node_from_torque",
      "sudo chmod 777 /usr/local/bin/delete_from_host_file",
      "sudo chmod 777 /opt/beegfs/sbin/beeond-remove-storage-node",
      "sudo chmod 777 /usr/local/bin/setup_zabbix",
      "sudo chmod 777 /usr/local/bin/zabbix_api.py",
      "sudo chmod 777 /usr/local/bin/delete_node_from_zabbix.py",
      "sudo chmod 644 /usr/lib/systemd/system/VALET_scheduler.service",
      "sudo chown root:root /usr/lib/systemd/system/VALET_scheduler.service",
      "sudo chmod 644 /usr/lib/systemd/system/VALET_scheduler.timer",
      "sudo chown root:root /usr/lib/systemd/system/VALET_scheduler.timer",
      "sudo chmod 755 /usr/local/bin/virtual_cluster_scheduler",
      "sudo chmod 755 /usr/local/bin/VALET_balancer_parser"
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo rm -rf /home/centos/tpackages/",
      "start_initial_unicore_cluster"
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo systemctl stop rpcbind.service",
      "sudo systemctl disable rpcbind.service",
      "sudo yum remove rpcbind -y"
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }

provisioner "remote-exec" {
    inline = [
      "sudo systemctl enable VALET_scheduler.timer",
      "sudo systemctl enable VALET_scheduler.service",
      "sudo systemctl start VALET_scheduler.timer",
      "sudo systemctl start VALET_scheduler.service"
    ]

    connection {
      type        = "ssh"
      private_key = "${file(var.private_key_path)}"
      user        = "centos"
      timeout     = "5m"
      host        = "${self.access_ip_v4}"
    }
  }
}



resource "openstack_compute_instance_v2" "compute" {
  count           = "${var.compute_node_count}"
  name            = "${var.name_prefix}compute-node-${count.index}"
  flavor_name     = "${var.flavors["compute"]}"
  image_id        = "${openstack_images_image_v2.vuc-image-compute.id}"
  key_pair        = "vuc_internal_key"
  security_groups = "${var.security_groups}"
  network {
    name = "${var.network_compute}"
  }

block_device {
    uuid                  = "${openstack_images_image_v2.vuc-image-compute.id}"
    source_type           = "image"
    destination_type      = "local"
    boot_index            = 0
    delete_on_termination = true
  }

block_device {
    uuid                  = "${element(openstack_blockstorage_volume_v2.beeond_volume_compute.*.id, count.index)}"
    source_type           = "volume"
    destination_type      = "volume"
    boot_index            = -1
    delete_on_termination = true
  }
}
