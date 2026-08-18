{
  flake.nixosModules.security = {
    security = {
      rtkit.enable = true;
      sudo-rs.enable = true;
    };
  };
}
