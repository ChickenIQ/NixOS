{
  flake.nixosModules.nix =
    { config, ... }:
    {
      programs = {
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
        settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };

      persistence.directories = [
        {
          directory = "/etc/nixos";
          user = config.vars.user.name;
        }
      ];

      system.stateVersion = config.vars.stateVersion;
      environment.variables.NIXPKGS_ALLOW_UNFREE = "1";
    };
}
