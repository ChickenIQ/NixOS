{
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.steam = lib.makeOverridable (
        args:
        let
          steam = pkgs.steam.override args;
          steam-silent = pkgs.writeShellScript "steam-launcher" ''
            [ "$#" -gt 0 ] || set -- -silent steam://open/main
            exec ${lib.getExe steam} "$@"
          '';
        in
        steam.overrideAttrs (old: {
          buildCommand = old.buildCommand + ''
            install -Dm755 ${steam-silent} "$out/bin/steam"
          '';
        })
      ) { };
    };
}
