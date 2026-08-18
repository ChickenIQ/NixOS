{
  flake.nixosModules.openssh = {
    services.openssh = {
      settings.PasswordAuthentication = false;
      enable = true;
    };

    persistence.files = [
      {
        file = "/etc/ssh/ssh_host_ed25519_key";
        configureParent = true;
        how = "symlink";
      }
      {
        file = "/etc/ssh/ssh_host_rsa_key";
        configureParent = true;
        how = "symlink";
      }
    ];
  };
}
