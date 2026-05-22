{ pkgs, lib, ... }:
{
  networking = {
    firewall.allowedUDPPorts = [ 9 ];
    interfaces.enp9s0.wakeOnLan.enable = true;
  };

  fileSystems."/home/emi/Games" = {
    fsType = "ntfs3";
    options = [ "nofail" ];
    device = "/dev/disk/by-label/Games";
  };

  hardware.keyboard.qmk = {
    enable = true;
    keychronSupport = true;
  };

  boot = {
    extraModprobeConfig = "softdep amdgpu pre: vfio vfio-pci";
    initrd.kernelModules = [
      "vfio_iommu_type1"
      "vfio_pci"
      "vfio"
    ];

    kernelParams = [
      "vfio-pci.ids=1002:13c0,1002:1640"
      "amd_iommu=on"
      "iommu=pt"
    ];
  };

}
