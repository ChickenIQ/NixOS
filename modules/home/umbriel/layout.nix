{
  flake.homeModules.umbriel = {
    programs.umbriel = {
      enable = true;
      settings = {
        workspaces.empty_above = true;

        layout = {
          width_presets = [
            0.5
            1.0
          ];

          scrolling = {
            expand_single_column = true;
            default_width_fraction = 0.5;
          };
        };

        window_rule = [
          {
            match.app_id = "^dev.noctalia.UmbrielSharePicker$";
            default_floating = true;
          }

          {
            match.app_id = "^(discord|steam)$";
            default_maximize = true;
          }

          {
            match = {
              title = "^notificationtoasts_\\d+_desktop$";
              app_id = "^steam$";
            };

            default_position = {
              anchor = "bottom_right";
              x = 10;
              y = 10;
            };
          }
        ];
      };
    };
  };
}
