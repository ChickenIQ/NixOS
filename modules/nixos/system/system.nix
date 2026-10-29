{
  flake.nixosModules.system = {
    hardware.enableRedistributableFirmware = true;
    security.sudo-rs.enable = true;
    services.bpftune.enable = true;
    boot.kernel.sysctl = {
      "vm.max_map_count" = 2147483642;
      "vm.swappiness" = 10;
    };
  };
}
