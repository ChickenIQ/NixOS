{
  flake.hosts."pc" =
    { self, ... }:
    {
      home-manager.users."${self.meta.user.name}".imports = [
        {
          programs = {
            mangohud.settings.fps_limit = 235;
            umbriel.settings.output = {
              "DP-2".vrr = "always";
              "HDMI-A-2".enabled = false;

            };
            # niri.settings.outputs = {
            #   "DP-2".variable-refresh-rate = true;
            #   "HDMI-A-2".enable = false;
            # };
          };
        }
      ];
    };
}
