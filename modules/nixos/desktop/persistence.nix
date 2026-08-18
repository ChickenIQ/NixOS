{
  preservation = {
    enable = true;
    preserveAt."/data" = {
      commonMountOptions = [
        "x-gvfs-hide"
        "x-gdu.hide"
      ];
      files = [
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_rsa_key";
          configureParent = true;
          how = "symlink";
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          configureParent = true;
          how = "symlink";
        }
      ];

      directories = [
        {
          directory = "/etc/nixos";
          user = "emi";
        }
        "/var/lib/systemd/timers"
        "/etc/NetworkManager"
        "/var/lib/bluetooth"
        "/var/lib/libvirt"
        "/var/lib/netbird"
        "/var/lib/docker"
        "/var/lib/nixos"
        "/var/lib/sbctl"
        "/etc/wireguard"
        "/var/cache"
        "/var/log"
      ];
    };
  };
}
