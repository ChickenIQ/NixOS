{
  flake.nixosModules.nvidia =
    { config, ... }:
    {
      hardware.nvidia = {
        open = true;
        nvidiaSettings = false;
        package = config.boot.kernelPackages.nvidiaPackages.beta;
      };

      services.xserver.videoDrivers = [ "nvidia" ];
    };
}
