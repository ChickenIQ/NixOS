{
  flake.homeModules.opencode =
    { pkgs, lib, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        tui.theme = lib.mkForce "oxocarbon";

        settings.permission.external_directory = {
          "/etc/profiles/per-user/**" = "allow";
          "/run/current-system/**" = "allow";
          "/nix/**" = "allow";
        };
      };
    };
}
