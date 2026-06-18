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
          mode = "0600";
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          mode = "0600";
        }
      ];

      directories = [
        {
          directory = "/etc/nixos";
          user = "emi";
        }
        "/etc/NetworkManager"
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

  systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
}
