{
  flake.homeModules.stylix =
    {
      config,
      pkgs,
      lib,
      options,
      ...
    }:
    {
      options.stylix.targets.luciole.enable = config.lib.stylix.mkEnableTarget "Luciole" true;

      config = lib.optionalAttrs (options.programs ? luciole) (
        lib.mkIf
          (config.stylix.enable && config.stylix.targets.luciole.enable && config.programs.luciole.enable)
          {
            programs.luciole.settings.browser.background_opacity = config.stylix.opacity.applications;

            xdg.configFile."luciole/colors.toml".source =
              (pkgs.formats.toml { }).generate "luciole-colors.toml"
                {
                  colors = with config.lib.stylix.colors.withHashtag; {
                    primary = base0D;
                    on_primary = base00;
                    primary_container = base02;
                    on_primary_container = base0D;

                    secondary = base0E;
                    on_secondary = base00;
                    secondary_container = base02;
                    on_secondary_container = base0E;

                    tertiary = base0C;
                    on_tertiary = base00;
                    tertiary_container = base02;
                    on_tertiary_container = base0C;

                    error = base08;
                    on_error = base00;
                    error_container = base02;
                    on_error_container = base08;

                    surface = base00;
                    on_surface = base05;
                    on_surface_variant = base04;
                    surface_container_highest = base02;
                    surface_container_high = base02;
                    surface_container_low = base00;
                    surface_container = base01;

                    outline_variant = base03;
                    shadow = base00;
                    scrim = "#000000";

                    hover = base0C;
                    on_hover = base00;
                  };
                };
          }
      );
    };
}
