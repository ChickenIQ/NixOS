{
  flake.hosts."pc" =
    { self, ... }:
    {
      environment.variables = {
        MANGOHUD_CONFIG = "preset=0,fps_limit=235";
        MANGOHUD = 1;
      };

      home-manager.users."${self.meta.user.name}".imports = [
        {
          programs.niri.settings.outputs = {
            "DP-2".variable-refresh-rate = true;
            "HDMI-A-2".enable = false;
          };
        }
      ];
    };
}
