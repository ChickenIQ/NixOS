{
  inputs,
  config,
  modulesPath,
  ...
}:
{
  imports = with inputs; [
    (modulesPath + "/installer/scan/not-detected.nix")
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
    sharedModules = [ { home.stateVersion = config.system.stateVersion; } ];
    users.emi.imports = [ (inputs.import-tree "${inputs.self}/modules/home") ];
  };
}
