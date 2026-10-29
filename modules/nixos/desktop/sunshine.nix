{
  flake.nixosModules.sunshine =
    { pkgs, ... }:
    {
      services.sunshine = {
        enable = true;
        capSysAdmin = true;
        openFirewall = true;
        package = pkgs.unstable.sunshine;
      };
    };
}
