{
  flake.nixosModules.peripherals = {
    services.udisks2.enable = true;
    hardware.i2c.enable = true;
  };
}
