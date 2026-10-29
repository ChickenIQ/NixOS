{
  flake.nixosModules.gpu = {
    hardware.graphics.enable = true;
    services.lact.enable = true;
  };
}
