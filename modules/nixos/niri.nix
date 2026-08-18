{
  flake.nixosModules.niri =
    {
      inputs,
      pkgs,
      ...
    }:
    {
      imports = [ inputs.niri.nixosModules.niri ];

      systemd.user.services.niri-flake-polkit.enable = false;
      niri-flake.cache.enable = false;

      xdg.portal = {
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

        config.niri = {
          default = [
            "gnome"
            "gtk"
          ];

          "org.freedesktop.impl.portal.Access" = "gtk";
          "org.freedesktop.impl.portal.FileChooser" = "gtk";
          "org.freedesktop.impl.portal.Notification" = "gtk";
          "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
        };
      };

      environment = {
        systemPackages = [
          pkgs.lxqt.lxqt-menu-data
          pkgs.xwayland-satellite
        ];

        etc."xdg/menus/applications.menu".source =
          "${pkgs.lxqt.lxqt-menu-data}/etc/xdg/menus/lxqt-applications.menu";
      };

      programs.niri = {
        enable = true;
        package = pkgs.niri;
      };
    };
}
