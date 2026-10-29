{
  flake.nixosModules.network-manager = {
    systemd.services.NetworkManager-wait-online.enable = false;
    networking.networkmanager.enable = true;

    persistence.directories = [ "/etc/NetworkManager" ];
  };
}
