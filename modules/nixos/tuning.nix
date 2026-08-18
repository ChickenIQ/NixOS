{
  flake.nixosModules.tuning = {
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
