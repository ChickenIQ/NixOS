{
  withSystem,
  inputs,
  self,
  lib,
  ...
}:
let
  persistenceModule =
    { options, lib, ... }:
    {
      options.persistence = lib.mkOption {
        type = options.preservation.preserveAt.type.nestedTypes.elemType or lib.types.deferredModule;
        description = "State stored on the persistent filesystem";
        default = { };
      };

      config = lib.optionalAttrs (options ? preservation.preserveAt) {
        preservation.preserveAt.${self.meta.persistence.name} = lib.mkMerge [
          { persistentStoragePath = lib.mkForce self.meta.persistence.directory; }
          (lib.mkAliasDefinitions options.persistence)
        ];
      };
    };
in
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
          persistenceModule
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
