{
  flake.homeModules.niri =
    { lib, ... }:
    let
      corner_radius = 5.0;
      maximized_apps = [
        "discord"
        "steam"
      ];
    in
    {
      programs.niri.settings.window-rules = [
        {
          matches = [ { app-id = "^(${lib.concatStringsSep "|" maximized_apps})$"; } ];
          open-maximized = true;
        }

        {
          clip-to-geometry = true;
          geometry-corner-radius = {
            bottom-right = corner_radius;
            bottom-left = corner_radius;
            top-right = corner_radius;
            top-left = corner_radius;
          };
        }

        {
          matches = [
            {
              title = "^notificationtoasts_\\d+_desktop$";
              app-id = "steam";
            }
          ];

          default-floating-position = {
            relative-to = "bottom-right";
            x = 10;
            y = 10;
          };
        }
      ];
    };
}
