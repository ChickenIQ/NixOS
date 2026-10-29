{ self, ... }:
{
  flake.hosts."box-0" = {
    imports = with self.nixosModules; [
      self.profiles.server
      intel
    ];

    networking.wireless.iwd = {
      enable = true;
      settings.General.EnableNetworkConfiguration = false;
    };

    persistence.directories = [ "/var/lib/iwd" ];
  };
}
