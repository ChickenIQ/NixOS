{
  environment.persistence."/data" = {
    files = [
      "/etc/ssh/ssh_host_ed25519_key"
      "/etc/ssh/ssh_host_rsa_key"
      "/etc/machine-id"
    ];

    directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/netbird"
      "/var/lib/nixos"
      "/var/lib/sbctl"
      "/etc/wireguard"
      "/var/cache"
      "/etc/nixos"
      "/var/log"
    ];
  };
}
