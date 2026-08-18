{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
    preservation.url = "github:nix-community/preservation";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      system = "x86_64-linux";
      stateVersion = "25.11";
      hosts = [
        "g15"
        "pc"
      ];
    in
    {
      nixosConfigurations = lib.genAttrs hosts (
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
    };
}
