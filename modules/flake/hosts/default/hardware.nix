{
  flake.hosts."default" = {
    hardware = {
      i2c.enable = true;
      graphics.enable = true;
      enableRedistributableFirmware = true;
    };
  };
}
