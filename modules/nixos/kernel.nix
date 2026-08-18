{
  flake.nixosModules.kernel =
    { pkgs, ... }:
    {
      boot = {
        kernel.sysctl = {
          "vm.swappiness" = 10;
          "vm.max_map_count" = 2147483642;
        };

        kernelPackages = pkgs.linuxPackages_zen;
      };
    };
}
