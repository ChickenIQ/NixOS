{
  flake.nixosModules.users =
    { self, lib, ... }:
    {
      time.timeZone = self.meta.timeZone;

      users = {
        mutableUsers = false;
        users.${self.meta.user.name} = {
          uid = 1000;
          isNormalUser = true;
          extraGroups = [ "wheel" ];
          hashedPassword = self.meta.user.hashedPassword;
          openssh.authorizedKeys.keys = self.meta.user.keys;
          description = lib.strings.toSentenceCase self.meta.user.name;
        };
      };
    };
}
