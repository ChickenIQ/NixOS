{
  flake.nixosModules.openssh =
    { config, ... }:
    {
      users.users = {
        ${config.vars.user.name}.openssh.authorizedKeys.keys = config.vars.user.keys;
        root.openssh.authorizedKeys.keys = config.vars.user.keys;
      };

      services.openssh = {
        enable = true;
        settings = {
          PubkeyAcceptedAlgorithms = "ssh-ed25519,sk-ssh-ed25519@openssh.com";
          PasswordAuthentication = false;
        };

        hostKeys = [
          {
            path = "/etc/ssh/ssh_host_ed25519_key";
            type = "ed25519";
          }
        ];
      };

      persistence.files = [
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          configureParent = true;
          how = "symlink";
        }
      ];
    };
}
