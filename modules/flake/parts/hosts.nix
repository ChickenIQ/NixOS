{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
{
  options.flake.hosts = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    description = "NixOS host modules";
    default = { };
  };

  options.flake.profiles = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.deferredModule;
    description = "NixOS profile modules";
    default = { };
  };

  config.flake.nixosConfigurations = lib.mapAttrs (
    hostname: hostModule:
    withSystem "x86_64-linux" (
      {
        specialArgs,
        system,
        pkgs,
        ...
      }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit specialArgs;

        modules = [
          {
            options.vars = lib.mkOption {
              type = lib.types.attrsOf lib.types.anything;
              default = { };
            };
          }

          {
            networking.hostName = hostname;
            nixpkgs = {
              hostPlatform = system;
              inherit pkgs;
            };
          }
        ]
        ++ [ hostModule ];
      }
    )
  ) self.hosts;
}
