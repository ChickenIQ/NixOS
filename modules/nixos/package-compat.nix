{
  flake.nixosModules.package-compat = {
    services.flatpak.enable = true;
    programs = {
      nix-ld.enable = true;
      appimage = {
        enable = true;
        binfmt = true;
      };
    };
  };
}
