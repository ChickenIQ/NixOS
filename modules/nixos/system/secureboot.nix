{
  flake.nixosModules.secureboot =
    { pkgs, ... }:
    {
      boot.loader.limine.secureBoot = {
        enable = true;
        autoGenerateKeys = true;
        autoEnrollKeys.enable = true;
      };

      environment.systemPackages = [ pkgs.sbctl ];
      persistence.directories = [ "/var/lib/sbctl" ];
    };
}
