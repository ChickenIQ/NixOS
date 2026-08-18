{
  flake.homeModules.stylix =
    { config, lib, ... }:
    let
      palette = with config.lib.stylix.colors.withHashtag; {
        mPrimary = base0D;
        mOnPrimary = base00;
        mSecondary = base0E;
        mOnSecondary = base00;
        mTertiary = base0C;
        mOnTertiary = base00;
        mError = base08;
        mOnError = base00;
        mSurface = base00;
        mOnSurface = base05;
        mHover = base0C;
        mOnHover = base00;
        mSurfaceVariant = base01;
        mOnSurfaceVariant = base04;
        mOutline = base03;
        mShadow = base00;

        terminal = {
          foreground = base05;
          background = base00;
          cursor = base05;
          cursorText = base00;
          selectionFg = base05;
          selectionBg = base02;

          normal = {
            black = base00;
            red = base08;
            green = base0B;
            yellow = base0A;
            blue = base0D;
            magenta = base0E;
            cyan = base0C;
            white = base05;
          };

          bright = {
            black = base03;
            red = base08;
            green = base0B;
            yellow = base0A;
            blue = base0D;
            magenta = base0E;
            cyan = base0C;
            white = base07;
          };
        };
      };
    in
    {
      options.stylix.targets.noctalia.enable = config.lib.stylix.mkEnableTarget "Noctalia v5" true;

      config = lib.mkIf (config.stylix.enable && config.stylix.targets.noctalia.enable) {
        programs.noctalia = {
          customPalettes.stylix.dark = palette;

          settings = {
            theme = {
              source = "custom";
              custom_palette = "stylix";
              mode = if config.stylix.polarity == "dark" then "dark" else "light";
            };

            wallpaper.default.path = config.stylix.image;
            osd.background_opacity = config.stylix.opacity.popups;
            shell.font_family = config.stylix.fonts.sansSerif.name;
            dock.background_opacity = config.stylix.opacity.desktop;
            notification.background_opacity = config.stylix.opacity.popups;
          };
        };
      };
    };
}
