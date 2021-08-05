locals {
  # format: 20210126T024552Z
  timestamp = regex_replace(timestamp(), "[- :]", "")

  # software versions
  java_version           = "11.0.12.7-1"
  node_exporter_version  = "1.2.0"
  docker_version         = "20.10.8"
  docker_compose_version = "1.29.2"
  ecr_helper_version     = "0.5.0"
  consul_version         = "1.10.1"
  nomad_version          = "1.1.3"

  # Canonical's official China/Global AWS account IDs
  source_ami_owners = [substr(var.region, 0, 3) == "cn-" ? "837727238323" : "099720109477"]

  # AMI names for OS releases/architectures
  ami_names = {
    focal_amd64  = "ubuntu/20.04/x86_64/${local.timestamp}"
    focal_arm64  = "ubuntu/20.04/arm64/${local.timestamp}"
  }
}
