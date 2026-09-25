{
  flake.nixosModules.kernel =
    { pkgs, ... }:
    {
      boot = {
        kernel.sysctl = {
          "vm.max_map_count" = 2147483642;
          "vm.swappiness" = 10;
        };

        kernelPackages = pkgs.unstable.linuxPackages_zen;
      };
    };
}
