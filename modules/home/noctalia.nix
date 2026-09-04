{
  flake.homeModules.noctalia =
    { inputs, pkgs, ... }:
    {
      imports = [ inputs.noctalia.homeModules.default ];
      home.packages = [ pkgs.ddcutil ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;

        settings = {
          bar.default = {
            dead_zone.actions.right = "none";
            margin_opposite_edge = 0;
            widget_spacing = 10;
            margin_edge = 5;
            margin_ends = 5;
            thickness = 40;
            capsule = true;
            padding = 10;
            scale = 1.05;

            start = [
              "launcher"
              "workspaces"
            ];

            end = [
              "tray"
              "volume"
              "network"
              "control-center"
            ];
          };

          widget = {
            workspaces = {
              hide_when_empty = true;
              show_labels = false;
            };
            network.show_label = false;
            volume.show_label = false;

            taskbar = {
              only_active_workspace = true;
              show_workspace_label = false;
            };
          };

          theme.templates = {
            enable_builtin_templates = false;
            enable_community_templates = false;
          };

          shell = {
            panel.open_near_click_control_center = true;
            clipboard_confirm_clear_history = false;
            clipboard_auto_paste = "off";
            setup_wizard_enabled = false;
            polkit_agent = true;
            screenshot = {
              save_to_file = false;
              show_cursor = true;
            };
          };

          osd.kinds.media = false;
          audio.enable_overdrive = true;
          desktop_widgets.enabled = false;
          control_center.sidebar = "full";
          brightness.enable_ddcutil = true;
        };
      };
    };
}
