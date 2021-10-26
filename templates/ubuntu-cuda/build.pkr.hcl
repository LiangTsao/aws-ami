build {
  description = "Linux CUDA image based on Ubuntu Server LTS."

  sources = [
    "source.amazon-ebs.focal_cuda_amd64",
  ]

  provisioner "file" {
    source      = "provisioners/bash-helpers.sh"
    destination = "/tmp/"
  }
  
  provisioner "file" {
    source      = "provisioners/cuda"
    destination = "/tmp/"
  }

  provisioner "shell" {
    environment_vars = [
      "BASH_HELPERS=/tmp/bash-helpers.sh",
      "CUDA_DRIVERS_VERSION=${local.cuda_driver_version}",
    ]
    scripts = [
      "provisioners/cuda/install-cuda-driver",
    ]
  }
  
  # https://www.packer.io/docs/post-processors/manifest
  # https://www.packer.io/docs/templates/hcl_templates/contextual-variables#source-variables
  post-processor "manifest" {
    custom_data = {
      region     = var.region
      image_name = local.ami_names[source.name]
    }
  }
}
