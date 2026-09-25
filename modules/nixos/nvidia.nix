{
  flake.nixosModules.nvidia =
    { pkgs, lib, ... }:
    {
      hardware.nvidia = {
        open = true;
        nvidiaSettings = false;
      };

      services.xserver.videoDrivers = [ "nvidia" ];
      boot.kernelPackages = lib.mkForce pkgs.linuxPackages;
    };
}
