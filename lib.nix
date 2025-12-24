{
  system ? "x86_64-linux",
  stateVersion ? "25.11",
  inputs,
  ...
}:
rec {
  lib = inputs.nixpkgs.lib;

  mkHosts =
    hosts:
    lib.genAttrs hosts (
      hostname:
      lib.nixosSystem {
        specialArgs = { inherit inputs; };
        inherit system;
        modules = [
          { system.stateVersion = stateVersion; }
          { networking.hostName = hostname; }
          (inputs.import-tree [
            ./hardware/${hostname}
            ./modules/nixos
          ])
        ];
      }
    );

  mkHomes =
    users:
    lib.genAttrs users (
      username:
      inputs.home-manager.lib.homeManagerConfiguration {
        extraSpecialArgs = { inherit inputs; };
        pkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };
        modules = [
          (inputs.import-tree [ ./modules/home ])
          {
            home = {
              homeDirectory = "/home/${username}";
              inherit stateVersion username;
            };
          }
        ];
      }
    );
}
