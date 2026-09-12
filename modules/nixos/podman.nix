{
  flake.nixosModules.podman =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.docker-compose ];

      virtualisation = {
        containers = {
          containersConf.settings.engine.compose_warning_logs = false;
          registries.search = [ "docker.io" ];
        };

        podman = {
          enable = true;
          defaultNetwork.settings.dns_enabled = true;
        };
      };
    };
}
