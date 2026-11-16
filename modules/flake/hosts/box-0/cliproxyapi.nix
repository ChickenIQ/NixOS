{
  flake.hosts."box-0" =
    { lib, ... }:
    {
      systemd.services.podman-cliproxyapi.serviceConfig.Restart = lib.mkForce "always";
      networking.firewall.interfaces.wt0.allowedTCPPorts = [ 8317 ];
      persistence.directories = [ "/var/lib/cliproxyapi" ];

      systemd.tmpfiles.rules = [
        "d /var/lib/cliproxyapi/auth 0700 root root -"
        "d /var/lib/cliproxyapi 0700 root root -"
      ];

      virtualisation.oci-containers.containers.cliproxyapi = {
        image = "docker.io/eceasy/cli-proxy-api:v8.0.67";
        extraOptions = [ "--network=host" ];

        volumes = [
          "/var/lib/cliproxyapi/config.yaml:/CLIProxyAPI/config.yaml"
          "/var/lib/cliproxyapi/auth:/root/.cli-proxy-api"
        ];
      };
    };
}
