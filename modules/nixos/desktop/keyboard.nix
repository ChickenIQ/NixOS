{
  services.keyd = {
    enable = true;
    keyboards.default.settings = {
      main = {
        meta = "layer(meta)";
        capslock = "layer(capslock)";
      };

      meta = {
        "insert" = "sysrq";
        "home" = "playpause";
        "end" = "previoussong";
        "pagedown" = "nextsong";
      };

      capslock = {
        "esc" = "`";
        "1" = "f1";
        "2" = "f2";
        "3" = "f3";
        "4" = "f4";
        "5" = "f5";
        "6" = "f6";
        "7" = "f7";
        "8" = "f8";
        "9" = "f9";
        "0" = "f10";
        "-" = "f11";
        "=" = "f12";
      };
    };
  };
}
