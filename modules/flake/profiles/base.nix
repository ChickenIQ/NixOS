{ self, ... }:
{
  flake.profiles.base =
    { lib, ... }:
    {
      imports = with self.nixosModules; [
        preservation
        home-manager
        reset-root
        netbird
        openssh
        system
        podman
        disko
        users
        boot
        nix
      ];

      vars = lib.mapAttrsRecursive (_: lib.mkDefault) {
        user = {
          name = "emi";
          hashedPassword = "$y$j9T$gqDrCnffMVyjRFFkMZkbj.$6gyoHmgemhUWrurlCr32oTK1mAzsVl0IAVJfXGLXiN4";
          keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJF4Waz2pv+NAEsLMT1kaFbtYjx6faBRPgHzlHdN30In" ];
        };

        stateVersion = "25.11";
        timeZone = "Europe/Bucharest";
      };
    };
}
