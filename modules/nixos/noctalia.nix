{
  flake.nixosModules.desktop =
    { inputs, pkgs, ... }:
    {
      imports = with inputs; [
        noctalia-greeter.nixosModules.default
        noctalia.nixosModules.default
        umbriel.nixosModules.default
      ];

      services.gnome.gnome-keyring.enable = true;
      environment.variables.NIXOS_OZONE_WL = 1;

      environment.etc."xdg/menus/applications.menu".source =
        "${pkgs.lxqt.lxqt-menu-data}/etc/xdg/menus/lxqt-applications-fm.menu";

      programs = {
        noctalia-greeter.enable = true;
        noctalia.enable = true;
        umbriel.enable = true;
      };
    };
}
