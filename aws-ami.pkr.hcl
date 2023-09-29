
data "amazon-ami" "amazon-ubuntu-2_ami" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    # owners = ["137112412989"]
    # owner-id = "137112412989"
  }
  owners      = ["amazon"]
  most_recent = true
  profile     = "dev"
}

variable "ssh_username" {
  type    = string
  default = "ubuntu"
}

variable "source_ami" {
  type    = string
  default = "ami-053b0d53c279acc90"
}

source "amazon-ebs" "ubuntu-jenkins" {
  region          = "us-east-1"
  ami_name        = "csye7125-jenkins_${formatdate("YYYY_MM_DD_hh_mm_ss", timestamp())}"
  profile         = "dev"
  ami_description = "AMI for CSYE 7125"
  ami_regions     = ["us-east-1"]
  instance_type   = "t2.micro"
  ami_users       = ["300978227218","423601559248"] ## check whether this working fine or not
  source_ami    = "${var.source_ami}"
  aws_polling {
    delay_seconds = 30
    max_attempts  = 50
  }
  ssh_username = "${var.ssh_username}"
  vpc_filter {
    filters = {
      "isDefault" : "true"
    }
  }
  launch_block_device_mappings {
    delete_on_termination = true
    device_name           = "/dev/xvda"
    volume_size           = 8
    volume_type           = "gp2"
  }
}

build {
  name    = "jenkin-packer"
  sources = ["source.amazon-ebs.ubuntu-jenkins"]
  provisioner "shell" {
    script = "./setup.sh"
  }
}




