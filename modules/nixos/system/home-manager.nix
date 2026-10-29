{
  flake.nixosModules.home-manager =
    {
      specialArgs,
      inputs,
      config,
      lib,
      ...
    }:
    {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      options.home = lib.mkOption {
        type = lib.types.deferredModule;
        description = "Home Manager module for the main user";
        default = { };
      };

      config.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        overwriteBackup = true;
        extraSpecialArgs = specialArgs;
        backupFileExtension = "hmBackup";
        users.${config.vars.user.name}.imports = [ config.home ];
        sharedModules = [ { home.stateVersion = config.vars.stateVersion; } ];
      };
    };
}
