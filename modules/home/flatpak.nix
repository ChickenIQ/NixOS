{
  flake.homeModules.flatpak =
    { inputs, ... }:
    {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

      services.flatpak = {
        enable = true;
        uninstallUnmanaged = true;
        update.auto.enable = true;
      };
    };
}
