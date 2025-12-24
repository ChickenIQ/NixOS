{
  zramSwap.enable = true;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    lact.enable = true;
    bpftune.enable = true;
    thermald.enable = true;
  };
}
