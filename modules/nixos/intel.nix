{
  flake.nixosModules.intel = {
    boot = {
      kernelParams = [ "intel_iommu=on" ];
      kernelModules = [ "kvm-intel" ];
    };

    hardware.cpu.intel.updateMicrocode = true;
  };
}
