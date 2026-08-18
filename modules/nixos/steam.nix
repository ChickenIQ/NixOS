{
  flake.nixosModules.steam =
    { pkgs, lib, ... }:
    {
      environment = {
        systemPackages = [ pkgs.mangohud ];
        variables = {
          ENABLE_LAYER_MESA_ANTI_LAG = 1;
          PROTON_FSR4_UPGRADE = 1;
        };
      };

      programs = {
        gamescope.enable = true;
        gamemode.enable = true;
        steam =
          let
            package = lib.makeOverridable (
              args:
              let
                steam = pkgs.steam.override args;

                launcher = pkgs.writeShellScript "steam-launcher" ''
                  [ "$#" -gt 0 ] || set -- -silent steam://open/main
                  exec ${lib.getExe steam} "$@"
                '';
              in
              steam.overrideAttrs (old: {
                buildCommand = old.buildCommand + ''
                  install -Dm755 ${launcher} "$out/bin/steam"
                '';
              })
            ) { };
          in
          {
            enable = true;
            inherit package;
            extraCompatPackages = [ pkgs.proton-ge-bin ];
          };
      };
    };
}
