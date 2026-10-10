{
  flake.homeModules.stylix =
    {
      config,
      lib,
      options,
      ...
    }:
    {
      options.stylix.targets.umbriel.enable = config.lib.stylix.mkEnableTarget "Umbriel" true;

      config =
        lib.mkIf
          (config.stylix.enable && config.stylix.targets.umbriel.enable && options.programs ? umbriel)
          {
            programs.umbriel.settings = {
              colors = with config.lib.stylix.colors.withHashtag; {
                background = base00;

                text_primary = base05;
                text_muted = base04;

                accent_primary = base0D;
                accent_secondary = base0C;

                warning = base0A;
                error = base08;

                insert_hint = "${base0C}80";
                backdrop = base00;

                border = {
                  focused = base0D;
                  unfocused = base03;

                  outer = base01;
                };

                overview = {
                  badge = base0D;
                  background_tint = "${base00}30";
                  workspace_background = "${base01}44";
                };

                tab_bar = {
                  text = base04;
                  active = base0D;
                  urgent = base08;
                  background = base01;
                  urgent_text = base00;
                  active_text = base00;
                  active_unfocused = base03;
                  active_unfocused_text = base05;
                };
              };

              input = lib.mkIf (config.stylix.cursor != null) {
                cursor = {
                  theme = config.stylix.cursor.name;
                  size = config.stylix.cursor.size;
                };
              };
            };
          };
    };
}
