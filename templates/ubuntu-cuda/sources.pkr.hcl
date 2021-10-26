source "amazon-ebs" "focal_cuda_amd64" {
  source_ami_filter {
    filters = {
      name                = "ubuntu/20.04/x86_64/*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = var.source_ami_owners
    most_recent = true
  }

  region          = var.region
  ami_regions     = var.regions_to_copy
  ami_users       = var.users_to_share
  ami_description = "Linux Deep Learning base image based on Ubuntu 20.04 (x86_64)"
  ami_name        = local.ami_names.focal_cuda_amd64
  
  subnet_id                   = var.subnet_id
  instance_type               = var.instance_type_amd64
  iam_instance_profile        = var.iam_instance_profile
  pause_before_connecting     = "30s"
  communicator                = "ssh"
  ssh_username                = "ubuntu"
  ssh_clear_authorized_keys   = true
  associate_public_ip_address = true

  tags = {
    Name                   = local.ami_names.focal_cuda_amd64
    build_region           = "{{ .BuildRegion }}"
    os_arch                = "{{ .SourceAMITags.os_arch }}"
    os_name                = "{{ .SourceAMITags.os_name }}"
    os_version             = "{{ .SourceAMITags.os_version }}"
    source_ami             = "{{ .SourceAMI }}"
    source_ami_name        = "{{ .SourceAMIName }}"
    git_commit             = var.git_commit
    cuda_driver_version    = local.cuda_driver_version
  }
}
