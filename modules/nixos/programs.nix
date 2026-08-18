{
  flake.nixosModules.programs =
    { pkgs, ... }:
    {
      services = {
        flatpak.enable = true;
        udisks2.enable = true;
      };

      programs = {
        nix-ld.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
      };

      environment.systemPackages = with pkgs; [
        killall
        lsof
        tree
        dig
        rar
      ];
    };
}
