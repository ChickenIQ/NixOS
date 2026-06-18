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
}
