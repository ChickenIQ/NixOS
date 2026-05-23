{
  services.thermald.enable = true;
  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "intel_iommu=on"
      "iommu=pt"
    ];
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    bluetooth.enable = true;
  };
}
