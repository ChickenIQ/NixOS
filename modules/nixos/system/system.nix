{
  inputs,
  config,
  ...
}:
{
  imports = with inputs; [
    impermanence.nixosModules.impermanence
    home-manager.nixosModules.home-manager
    lanzaboote.nixosModules.lanzaboote
    nix-index.nixosModules.nix-index
    facter.nixosModules.facter
    disko.nixosModules.disko
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    overwriteBackup = true;
    backupFileExtension = "hmBackup";
    extraSpecialArgs = { inherit inputs; };
    sharedModules = [ { home.stateVersion = config.system.stateVersion; } ];
    users.emi.imports = [ (inputs.import-tree "${inputs.self}/modules/home") ];
  };

  services = {
    kmscon.enable = true;
    btrfs.autoScrub.enable = true;
  };

  facter.reportPath = "${inputs.self}/hardware/${config.networking.hostName}/facter.json";
}
