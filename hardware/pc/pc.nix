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

  boot.kernelParams = [
    "amd_iommu=on"
    "iommu=pt"
  ];
}
