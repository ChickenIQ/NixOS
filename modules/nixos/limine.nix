{
  flake.nixosModules.limine =
    { pkgs, ... }:
    {
      boot.loader = {
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

      environment.systemPackages = [ pkgs.sbctl ];
      persistence.directories = [ "/var/lib/sbctl" ];
    };
}
