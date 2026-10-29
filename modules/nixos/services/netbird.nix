{
  flake.nixosModules.netbird =
    { pkgs, ... }:
    {
      services.netbird = {
        enable = true;
        clients.default.port = 51829;
        package = pkgs.unstable.netbird;
      };

      persistence.directories = [ "/var/lib/netbird" ];
    };
}
