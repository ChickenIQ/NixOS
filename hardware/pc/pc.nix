{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  swapDevices = [ { device = "/dev/disk/by-partlabel/swap"; } ];

  networking = {
    firewall.allowedUDPPorts = [ 9 ];
    interfaces = {
      enp9s0.wakeOnLan.enable = true;
      enp10s0.wakeOnLan.enable = true;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
    keyboard.qmk = {
      enable = true;
      keychronSupport = true;
    };
  };

  boot = {
    extraModprobeConfig = "softdep amdgpu pre: vfio vfio-pci";
    kernelModules = [
      "vfio_iommu_type1"
      "vfio_pci"
      "kvm-amd"
      "vfio"
    ];

    kernelParams = [
      "vfio-pci.ids=1002:13c0,1002:1640"
      "amd_iommu=on"
      "iommu=pt"
    ];
  };
}
