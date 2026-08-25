{
  flake.homeModules.niri = {
    programs.niri.settings = {
      gestures.hot-corners.enable = false;
      clipboard.disable-primary = true;

      input.mouse = {
        accel-profile = "flat";
        accel-speed = -0.2;
      };
    };
  };
}
