{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    flatpak.url = "github:in-a-dil-emma/declarative-flatpak";
    facter.url = "github:nix-community/nixos-facter-modules";
    impermanence.url = "github:nix-community/impermanence";
    import-tree.url = "github:vic/import-tree";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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
      lib = import ./lib.nix { inherit inputs; };
    in
    {
      nixosConfigurations = lib.mkHosts [
        "g15"
        "pc"
      ];
    };
}
