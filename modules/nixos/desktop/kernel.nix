{
  flake.nixosModules.kernel =
    { pkgs, config, ... }:
    {
      boot = {
        extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
        kernelPackages = pkgs.linuxPackages_zen;
        kernelModules = [ "v4l2loopback" ];
      };
    };
}
