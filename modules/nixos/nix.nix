{
  flake.nixosModules.nix =
    { inputs, self, ... }:
    {
      imports = [ inputs.nix-index.nixosModules.nix-index ];

      programs = {
        nix-index-database.comma.enable = true;
        nh = {
          enable = true;
          flake = "/etc/nixos";
          clean = {
            enable = true;
            extraArgs = "--keep-since 7d --keep 3";
          };
        };
      };

      nix = {
        channel.enable = false;
        optimise.automatic = true;
        settings.experimental-features = "nix-command flakes";
      };

      persistence.directories = [
        {
          directory = "/etc/nixos";
          user = self.meta.user.name;
        }
      ];

      system.stateVersion = self.meta.stateVersion;
      environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
    };
}
