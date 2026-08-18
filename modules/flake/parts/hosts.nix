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
          (self.hosts.default or { })
          hostModule
          {
            networking.hostName = hostname;
            nixpkgs = {
              hostPlatform = system;
              inherit pkgs;
            };
          }
        ];
      }
    )
  ) (lib.removeAttrs self.hosts [ "default" ]);
}
