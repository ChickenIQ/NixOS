{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings.dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
    };
  };

  environment.systemPackages = with pkgs; [ docker-compose ];
  systemd.services.libvirtd.serviceConfig.LoadCredentialEncrypted = "";

  users.users.emi.extraGroups = [
    "libvirtd"
    "docker"
  ];

  networking.firewall.extraCommands = ''
    iptables -I FORWARD -s 192.168.122.0/24 -d 10.0.0.0/8 -j DROP
    iptables -I FORWARD -s 192.168.122.0/24 -d 100.64.0.0/10 -j DROP
    iptables -I FORWARD -s 192.168.122.0/24 -d 172.16.0.0/12 -j DROP
    iptables -I FORWARD -s 192.168.122.0/24 -d 192.168.0.0/16 -j DROP
  '';
}
