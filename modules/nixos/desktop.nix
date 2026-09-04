{
  flake.nixosModules.desktop =
    { inputs, pkgs, ... }:
    {
      imports = with inputs; [
        noctalia-greeter.nixosModules.default
        noctalia.nixosModules.default
        umbriel.nixosModules.default
      ];

      services = {
        gnome.gnome-keyring.enable = true;
        udisks2.enable = true;
        bpftune.enable = true;
        lact.enable = true;
        scx = {
          enable = true;
          scheduler = "scx_lavd";
        };
      };

      security = {
        sudo-rs.enable = true;
        rtkit.enable = true;
      };

      environment = {
        variables = {
          ENABLE_LAYER_MESA_ANTI_LAG = 1;
          NIXOS_OZONE_WL = 1;
        };

        etc."xdg/menus/applications.menu".source =
          "${pkgs.lxqt.lxqt-menu-data}/etc/xdg/menus/lxqt-applications.menu";
      };

      programs = {
        noctalia-greeter.enable = true;
        noctalia.enable = true;
        umbriel.enable = true;
      };
    };
}
