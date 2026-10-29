{
  flake.homeModules.umbriel =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      toml = pkgs.formats.toml { };
    in
    {
      options.programs.umbriel.settings = lib.mkOption {
        type = toml.type;
        default = { };
      };

      config = {
        xdg.configFile."umbriel/config.toml".source =
          toml.generate "umbriel-config.toml" config.programs.umbriel.settings;

        programs.umbriel.settings = {
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
