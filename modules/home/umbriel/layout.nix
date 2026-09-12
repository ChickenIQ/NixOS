{
  flake.homeModules.umbriel = {
    programs.umbriel.settings = {
      workspaces.empty_above = true;

      layout = {
        scrolling = {
          center_underfull_strip = false;
          default_width_fraction = 0.5;
        };

        width_presets = [
          0.5
          1.0
        ];
      };

      window_rule = [
        {
          match.app_id = "^dev.noctalia.UmbrielSharePicker$";
          default_floating = true;
        }

        {
          match.title = "^notificationtoasts_.+_desktop";
          default_position = {
            anchor = "bottom_right";
            x = 10;
            y = 10;
          };
        }

        {
          match.app_id = "^(discord|steam)$";
          default_maximize = true;
        }

        {
          match.app_id = "^steam_app_[0-9]+$";
          default_floating = false;
        }

        {
          match.content_type = "game";
          default_floating = false;
        }

        {
          match.is_alone = true;
          default_maximize = true;
        }
      ];
    };
  };
}
