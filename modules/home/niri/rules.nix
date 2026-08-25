{
  flake.homeModules.niri =
    { lib, ... }:
    let
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
