{
  flake.homeModules.stylix =
    { inputs, pkgs, ... }:
    {
      imports = [ inputs.stylix.homeModules.stylix ];

      stylix = {
        enable = true;
        overlays.enable = false;

        base16Scheme = "${pkgs.base16-schemes}/share/themes/oxocarbon-dark.yaml";
        image = ./wallpaper.png;
        polarity = "dark";

        icons = {
          enable = true;
          package = pkgs.kdePackages.breeze-icons;
          dark = "breeze-dark";
          light = "breeze";
        };

        cursor = {
          package = pkgs.kdePackages.breeze;
          name = "breeze_cursors";
          size = 24;
        };
      };
    };
}
