{
  flake.nixosModules.session =
    {
      config,
      inputs',
      pkgs,
      ...
    }:
    {
      systemd.user.services.umbriel.environment.TZDIR = "/etc/zoneinfo";
      time.timeZone = config.vars.timeZone;

      # TMP until upstream
      xdg.portal = {
        config.umbriel = {
          "org.freedesktop.impl.portal.FileChooser" = "luciole;gtk";
          default = "umbriel;gtk";
        };
        extraPortals = [ inputs'.luciole.packages.default ];
      };

      services = {
        displayManager.noctalia-greeter.enable = true;
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
        scx-loader = {
          enable = true;
          config.default_sched = "scx_lavd";
        };
      };

      environment = {
        variables.NIXOS_OZONE_WL = 1;

        etc."xdg/menus/applications.menu".source =
          "${pkgs.lxqt.lxqt-menu-data}/etc/xdg/menus/lxqt-applications.menu";
      };

      programs = {
        noctalia.enable = true;
        umbriel.enable = true;
      };
    };
}
