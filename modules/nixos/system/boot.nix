{
  flake.nixosModules.boot =
    { config, lib, ... }:
    {
      boot.loader = {
        limine = {
          enableEditor = lib.mkIf (!config.boot.loader.limine.secureBoot.enable) true;
          style.wallpapers = [ ];
          enable = true;
        };

        timeout = 1;
        efi.canTouchEfiVariables = true;
      };
    };
}
