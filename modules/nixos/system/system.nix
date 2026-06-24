{ pkgs, ... }:
{
  boot = {
    loader = {
      limine = {
        enable = true;
        style.wallpapers = [ ];
        secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys.enable = true;
        };
      };
      timeout = 1;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.max_map_count" = 2147483642;
    };

    zswap.enable = true;
    kernelPackages = pkgs.linuxPackages_zen;
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "reboot-windows" ''
      export PATH=$PATH:${pkgs.efibootmgr}/bin
      ENTRY=$(efibootmgr | awk '/Windows Boot Manager/ {print substr($1, 5, 4); exit}')
      [ -z "$ENTRY" ] && echo "Windows Boot Manager entry not found" && exit 1
      efibootmgr --bootnext "$ENTRY" && reboot
    '')
  ];

  users = {
    mutableUsers = false;
    users.emi = {
      uid = 1000;
      description = "Emi";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPassword = "$y$j9T$gqDrCnffMVyjRFFkMZkbj.$6gyoHmgemhUWrurlCr32oTK1mAzsVl0IAVJfXGLXiN4";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In"
      ];
    };
  };

  systemd = {
    sleep.settings.Sleep.AllowHibernation = "no";
    services.NetworkManager-wait-online.enable = false;
    suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };

  time.timeZone = "Europe/Bucharest";
  security.sudo.extraConfig = "Defaults lecture=never,timestamp_type=global,pwfeedback";
}
