{
  flake.hosts."pc" =
    { self, ... }:
    {
      home-manager.users."${self.meta.user.name}".imports = [
        {
          programs = {
            mangohud.settings.fps_limit = 235;
            umbriel.settings.output = {
              "HDMI-A-2".enabled = false;
              "DP-2".vrr = "always";
            };
          };
        }
      ];
    };
}
