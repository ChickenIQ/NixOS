{
  users = {
    mutableUsers = false;
    users.emi = {
      description = "Emi";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      hashedPassword = "$y$j9T$gqDrCnffMVyjRFFkMZkbj.$6gyoHmgemhUWrurlCr32oTK1mAzsVl0IAVJfXGLXiN4";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In"
      ];
    };
  };

  time.timeZone = "Europe/Bucharest";
  security.sudo.extraConfig = "Defaults lecture=never,timestamp_type=global,pwfeedback";
}
