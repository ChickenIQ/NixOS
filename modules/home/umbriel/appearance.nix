{
  flake.homeModules.umbriel = {
    programs.umbriel.settings = {
      appearance = {
        border_width = 2;
        corner_radius = 5;
      };

      layout.gap = 4;

      animation = {
        beziers.smoothSpring = [
          0.327
          0.688
          0.114
          1.0
        ];

        duration_ms = 300;
        curve = "smoothSpring";

        windows_in = {
          scale = 0.5;
          duration_ms = 200;
          curve = "ease-out-expo";
        };

        windows_out = {
          duration_ms = 200;
          curve = "ease-out-quad";
        };
      };
    };
  };
}
