{
  flake.nixosModules.programs =
    { inputs, pkgs, ... }:
    {
      imports = [ inputs.nix-index.nixosModules.nix-index ];

      services.flatpak.enable = true;

      programs = {
        nix-index-database.comma.enable = true;
        nix-ld.enable = true;
        appimage = {
          enable = true;
          binfmt = true;
        };
      };

      environment.systemPackages = with pkgs; [
        killall
        unzip
        lsof
        tree
        dig
        rar
        bat
        jq
        yq
      ];
    };
}
