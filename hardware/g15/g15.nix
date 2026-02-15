{
  services.thermald.enable = true;

  boot.kernelParams = [
    "intel_iommu=on"
    "iommu=pt"
  ];
}
