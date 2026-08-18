{
  flake.nixosModules.home-manager =
    {
      specialArgs,
      inputs,
      self,
      ...
    }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        overwriteBackup = true;
        extraSpecialArgs = specialArgs;
        backupFileExtension = "hmBackup";
        sharedModules = [ { home.stateVersion = self.meta.stateVersion; } ];
      };
    };
}
