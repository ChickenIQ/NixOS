{
  flake.homeModules.umbriel =
    { inputs, ... }:
    {
      imports = [ inputs.umbriel.homeModules.default ];

      programs.umbriel = {
        enable = true;
        settings = {
          general = {
            focus_on_activate = true;
            show_cheatsheet = false;
          };

          input = {
            middle_click_paste = false;

            mouse = {
              accel_profile = "flat";
              sensitivity = -0.2;
            };
          };
        };
      };
    };
}
