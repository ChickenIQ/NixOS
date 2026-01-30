{ pkgs, ... }:
{
  programs.virt-manager.enable = true;

  virtualisation = {
    docker.enable = true;
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

  users.users.emi.extraGroups = [
    "libvirtd"
    "docker"
  ];
}
