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
        gestures.hot-corners.enable = false;
        clipboard.disable-primary = true;
        prefer-no-csd = true;

        input.mouse = {
          accel-profile = "flat";
          accel-speed = -0.2;
        };

        layout = {
          default-column-width.proportion = 0.5;
          empty-workspace-above-first = true;
          focus-ring.width = 2;
          gaps = 10;

          preset-column-widths = [
            { proportion = 0.5; }
            { proportion = 1.0; }
          ];
        };
      };
    };
}
