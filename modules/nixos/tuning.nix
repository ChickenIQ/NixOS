{
  flake.nixosModules.tuning = {
    environment.variables.ENABLE_LAYER_MESA_ANTI_LAG = 1;

    services = {
      bpftune.enable = true;
      lact.enable = true;
      scx = {
        enable = true;
        scheduler = "scx_lavd";
      };
    };
  };
}
