# Ubuntu use rolling kernels by default
# After version 202105, Ubuntu 20.04 AMIs moved to kernel 5.8
# We want to stay on 5.4 LTS kernel, so here we are pinning to 202105
# See provisioners/apt-kernel.sh
source "amazon-ebs" "focal_cuda_amd64" {
  source_ami_filter {
    filters = {
      name                = "ubuntu/20.04/x86_64/202110*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = local.source_ami_owners
    most_recent = true
  }

  region          = var.region
  ami_regions     = var.regions_to_copy
  ami_users       = var.users_to_share
  ami_description = "Linux Deep Learning base image based on Ubuntu 20.04 (x86_64)"
  ami_name        = local.ami_names.focal_cuda_amd64
  
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type_cuda_amd64
  iam_instance_profile        = var.iam_instance_profile
  pause_before_connecting     = "30s"
  communicator                = "ssh"
  ssh_username                = "ubuntu"
  ssh_clear_authorized_keys   = true
  associate_public_ip_address = true

  tags = {
    Name                   = local.ami_names.focal_cuda_amd64
    build_region           = "{{ .BuildRegion }}"
    os_arch                = "x86_64"
    os_name                = "Ubuntu"
    os_version             = "20.04"
    source_ami             = "{{ .SourceAMI }}"
    source_ami_name        = "{{ .SourceAMIName }}"
    timezone               = var.timezone
    git_commit             = var.git_commit
    cuda_driver_version    = local.cuda_driver_version
  }
}
