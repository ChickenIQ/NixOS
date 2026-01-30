{ pkgs, ... }:
{
  boot = {
    loader = {
      timeout = 0;
      efi.canTouchEfiVariables = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 2147483642;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
