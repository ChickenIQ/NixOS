{
  flake.hosts."pc" =
    { self, ... }:
    {
      home-manager.users."${self.meta.user.name}".imports = [
        {
          programs.mangohud.settings.fps_limit = 235;
          programs.niri.settings.outputs = {
            "DP-2".variable-refresh-rate = true;
            "HDMI-A-2".enable = false;
          };
        }
      ];
    };
}
