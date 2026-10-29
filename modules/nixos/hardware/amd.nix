{
  flake.nixosModules.amd = {
    hardware = {
      cpu.amd.updateMicrocode = true;
      amdgpu.overdrive.enable = true;
    };

    boot = {
      kernelModules = [ "kvm-amd" ];
      kernelParams = [ "amd_iommu=on" ];
    };
  };
}
