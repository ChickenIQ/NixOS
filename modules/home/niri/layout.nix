{
  flake.homeModules.niri =
    { pkgs, lib, ... }:
    let
      startup_apps = [ "${lib.getExe pkgs.self.oniri} --tiling-layout --reclaim-space" ];
    in
    {
      programs.niri.settings = {
        spawn-at-startup = map (c: { argv = lib.splitString " " c; }) startup_apps;
        debug.honor-xdg-activation-with-invalid-serial = true;
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = true;

        layout =
          let
            default_width = 0.5;
          in
          {
            default-column-width.proportion = default_width;
            empty-workspace-above-first = true;
            focus-ring.width = 1;
            gaps = 5;

            preset-column-widths = [
              { proportion = default_width; }
              { proportion = 1.0; }
            ];
          };

        window-rules = [
          {
            clip-to-geometry = true;
            geometry-corner-radius =
              let
                radius = 5.0;
              in
              {
                bottom-right = radius;
                bottom-left = radius;
                top-right = radius;
                top-left = radius;
              };
          }
        ];
      };
    };
}
