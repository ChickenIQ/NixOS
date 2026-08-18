{
  flake.homeModules.stylix =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      scheme = lib.replaceStrings [ " " ] [ "" ] config.lib.stylix.colors.scheme;
      kdeGlobals = pkgs.runCommand "kde-config" { } ''
        install -Dm444 ${config.home.path}/share/color-schemes/${scheme}.colors $out/kdeglobals
      '';
    in
    {
      stylix.targets.qt.enable = false;

      qt = {
        enable = true;
        style.name = "breeze";
        platformTheme = {
          name = "kde";
          package = with pkgs.kdePackages; [
            plasma-integration
            kio
          ];
        };
      };

      services.flatpak.overrides.global = {
        Context.filesystems = [ "${kdeGlobals}:ro" ];
        Environment = {
          XDG_CONFIG_DIRS = "${kdeGlobals}:/app/etc/xdg:/etc/xdg";
          QT_QPA_PLATFORMTHEME = config.qt.platformTheme.name;
          QT_STYLE_OVERRIDE = config.qt.style.name;
        };
      };

      xdg = {
        systemDirs.config = [ "${config.xdg.dataHome}/stylix-kde" ];
        dataFile = {
          "plasma/look-and-feel".source = config.home.path + "/share/plasma/look-and-feel";
          "color-schemes".source = config.home.path + "/share/color-schemes";
          "stylix-kde/kdeglobals".source = "${kdeGlobals}/kdeglobals";
        };
      };
    };
}
