{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    nvidiaSettings = false;
    powerManagement.enable = true;
  };

  boot = {
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];

    initrd.kernelModules = [
      "nvidia"
      "nvidia_uvm"
      "nvidia_drm"
      "nvidia_modeset"
    ];
  };
}
