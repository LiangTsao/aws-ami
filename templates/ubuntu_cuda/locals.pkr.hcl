locals {
  # format: 20210126T024552Z
  timestamp = regex_replace(timestamp(), "[- :]", "")

  # software versions
  cuda_driver_version    = "470.57.02-1"

  # Canonical's official China/Global AWS account IDs
  source_ami_owners = [substr(var.region, 0, 3) == "cn-" ? "552340821054" : "552340821054"]

  # AMI names for OS releases/architectures
  ami_names = {
    focal_cuda_amd64 = "ubuntu/20.04/cuda/x86_64/${local.timestamp}"
  }
}
