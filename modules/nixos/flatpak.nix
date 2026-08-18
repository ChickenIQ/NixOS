{
  flake.nixosModules.flatpak =
    { inputs, ... }:
    {
      imports = [ inputs.flatpak.nixosModules.nix-flatpak ];

      services.flatpak = {
        enable = true;
        update.auto.enable = true;
        uninstallUnmanaged = true;
      };

      persistence.directories = [ "/var/lib/flatpak" ];
    };
}
