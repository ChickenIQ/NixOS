{
  environment.variables."KWIN_DRM_DEVICES" = "/dev/dri/card0:/dev/dri/card1:/dev/dri/card2";

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;
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
