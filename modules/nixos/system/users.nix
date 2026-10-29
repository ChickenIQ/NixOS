{
  flake.nixosModules.users =
    { config, lib, ... }:
    {
      users = {
        mutableUsers = false;
        users.${config.vars.user.name} = {
          uid = 1000;
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          hashedPassword = config.vars.user.hashedPassword;
          description = lib.strings.toSentenceCase config.vars.user.name;
        };
      };
    };
}
