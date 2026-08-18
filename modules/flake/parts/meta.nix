{
  flake.meta = {
    user = {
      name = "emi";
      password = "$y$j9T$gqDrCnffMVyjRFFkMZkbj.$6gyoHmgemhUWrurlCr32oTK1mAzsVl0IAVJfXGLXiN4";
      keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In" ];
    };

    persistence = rec {
      name = "data";
      directory = "/${name}";
    };

    stateVersion = "25.11";
    timeZone = "Europe/Bucharest";
  };
}
