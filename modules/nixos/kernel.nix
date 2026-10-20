{
  flake.nixosModules.kernel =
    { pkgs, config, ... }:
    {
      boot = {
        kernel.sysctl = {
          "vm.max_map_count" = 2147483642;
          "vm.swappiness" = 10;
        };

        extraModulePackages = with config.boot.kernelPackages; [
          v4l2loopback
        ];

        kernelModules = [
          "v4l2loopback"
          "ntsync"
        ];

        kernelPackages = pkgs.unstable.linuxPackages_latest;
      };
    };
}
