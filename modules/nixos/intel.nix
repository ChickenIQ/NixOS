{
  flake.nixosModules.intel = {
    boot = {
      kernelModules = [ "kvm-intel" ];
      kernelParams = [ "intel_iommu=on" ];
    };

    hardware.cpu.intel.updateMicrocode = true;
  };
}
