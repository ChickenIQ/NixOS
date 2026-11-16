{ self, ... }:
{
  flake.hosts."box-0" =
    { config, lib, ... }:
    {
      imports = with self.nixosModules; [
        self.profiles.server
        intel
      ];

      users.users = lib.genAttrs [ config.vars.user.name "root" ] (_: {
        linger = true;
      });

      networking.wireless.iwd = {
        enable = true;
        settings = {
          DriverQuirks.PowerSaveDisable = "*";
          General.EnableNetworkConfiguration = false;
        };
      };

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      zramSwap.enable = true;

      persistence.directories = [ "/var/lib/iwd" ];

      vars.user.name = "box";
      security.sudo-rs.wheelNeedsPassword = false;
    };
}
