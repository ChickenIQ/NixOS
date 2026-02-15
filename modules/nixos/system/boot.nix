{ pkgs, ... }:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        style.wallpapers = [ ];
        secureBoot.enable = true;
      };
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 2147483642;
    };

    kernelPackages = pkgs.linuxPackages_zen;
    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "reboot-windows" ''
      export PATH=$PATH:${pkgs.efibootmgr}/bin
      ENTRY=$(efibootmgr | awk '/Windows Boot Manager/ {print substr($1, 5, 4); exit}')
      [ -z "$ENTRY" ] && echo "Windows Boot Manager entry not found" && exit 1
      efibootmgr --bootnext "$ENTRY" && reboot
    '')
  ];
}
