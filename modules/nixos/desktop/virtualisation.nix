{ pkgs, lib, ... }:
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

  networking.firewall.extraCommands =
    let
      src = "192.168.122.0/24";
      dsts = [
        "10.0.0.0/8"
        "100.64.0.0/10"
        "172.16.0.0/12"
        "192.168.0.0/16"
      ];
    in
    lib.concatMapStringsSep "\n" (dst: "iptables -I FORWARD -s ${src} -d ${dst} -j DROP") dsts;
}
