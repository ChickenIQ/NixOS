{
  flake.nixosModules.docker =
    { self, pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.docker-compose ];

      virtualisation.docker = {
        enable = true;
        daemon.settings.dns = [
          "1.1.1.1"
          "8.8.8.8"
        ];
      };

      persistence.directories = [ "/var/lib/docker" ];
      users.users.${self.meta.user.name}.extraGroups = [ "docker" ];
    };
}
