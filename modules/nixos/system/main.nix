{
  inputs,
  config,
  ...
}:
{
  imports = with inputs; [
    preservation.nixosModules.preservation
    home-manager.nixosModules.home-manager
    nix-index.nixosModules.nix-index
    disko.nixosModules.disko
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "hmBackup";
    extraSpecialArgs = { inherit inputs; };
    users.emi.imports = [ (inputs.import-tree "${inputs.self}/modules/home") ];
    sharedModules = with inputs; [
      { home.stateVersion = config.system.stateVersion; }
      nvf.homeManagerModules.default
      flatpak.homeModules.default
    ];
  };

  nix = {
    channel.enable = false;
    optimise.automatic = true;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final.stdenv.hostPlatform) system;
          inherit (final) overlays config;
        };
      })
    ];
  };

}
