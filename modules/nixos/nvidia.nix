{
  flake.nixosModules.nvidia = {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      open = true;
      nvidiaSettings = false;
    };
  };
}
