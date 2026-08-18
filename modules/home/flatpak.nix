{
  flake.homeModules.flatpak =
    { inputs, ... }:
    {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];

      services.flatpak = {
        uninstallUnmanaged = true;
        update.auto.enable = true;
      };
    };
}
