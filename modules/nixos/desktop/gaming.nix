{
  flake.nixosModules.gaming =
    { pkgs, ... }:
    {
      environment.variables = {
        ENABLE_LAYER_MESA_ANTI_LAG = 1;
        PROTON_FSR4_UPGRADE = 1;
      };

      programs = {
        gamemode.enable = true;

        gamescope = {
          enable = true;
          enableWsi = true;
        };

        steam = {
          enable = true;
          package = pkgs.self.steam;
          extraCompatPackages = with pkgs; [
            self.proton-cachyos
            proton-ge-bin
          ];
        };
      };

      boot.kernelModules = [ "ntsync" ];
    };
}
