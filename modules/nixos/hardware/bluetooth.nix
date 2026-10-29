{
  flake.nixosModules.bluetooth = {
    hardware.bluetooth.enable = true;
    persistence.directories = [ "/var/lib/bluetooth" ];
  };
}
