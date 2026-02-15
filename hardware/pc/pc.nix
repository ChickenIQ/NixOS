{
  lib,
  pkgs,
  inputs,
  ...
}:
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

  boot = {
    kernelParams = [
      "iommu=pt"
      "amd_iommu=on"
    ];
    # kernelPackages = lib.mkForce (
    #   pkgs.linuxPackagesFor (
    #     inputs.nix-cachyos-kernel.packages."x86_64-linux".linux-cachyos-latest-lto-zen4
    #   )
    # );
  };
}
