{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  swapDevices = [ { device = "/dev/disk/by-partlabel/swap"; } ];

  networking.firewall.allowedUDPPorts = [ 9 ];

  systemd.network.links."10-lan" = {
    matchConfig.Path = "pci-0000:0c:00.0";
    linkConfig = {
      Name = "lan";
      WakeOnLan = "magic";
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    bluetooth.enable = true;
    # keyboard.qmk = {
    #   enable = true;
    #   keychronSupport = true;
    # };
  };

  environment.variables = {
    MANGOHUD_CONFIG = "preset=0,fps_limit=235";
    ENABLE_LAYER_MESA_ANTI_LAG = 1;
    PROTON_FSR4_UPGRADE = 1;
    MANGOHUD = 1;
  };

  boot = {
    zswap.enable = true;

    # extraModprobeConfig = "softdep amdgpu pre: vfio vfio-pci";
    kernelModules = [
      "vfio_iommu_type1"
      "vfio_pci"
      "kvm-amd"
      "vfio"
    ];

    kernelParams = [
      # "vfio-pci.ids=1002:13c0,1002:1640"
      "amd_iommu=on"
      "iommu=pt"
    ];
  };
}
