{
  flake.nixosModules.steam =
    { pkgs, ... }:
    {
      environment.variables.PROTON_FSR4_UPGRADE = 1;

      programs = {
        gamescope.enable = true;
        gamemode.enable = true;
        steam = {
          enable = true;
          package = pkgs.self.steam;
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
      };
    };
}
