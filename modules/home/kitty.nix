{
  flake.homeModules.kitty =
    {
      config,
      lib,
      ...
    }:
    {
      qt.kde.settings.kdeglobals.General.TerminalApplication = lib.getExe config.programs.kitty.package;

      programs.kitty = {
        enable = true;

        mouseBindings = {
          "right press" = "ungrabbed combine : copy_to_clipboard : clear_selection";
          "left click" = "ungrabbed mouse_handle_click selection prompt";
          "ctrl+left release" = "ungrabbed mouse_handle_click link";
        };

        keybindings = {
          "ctrl+shift+c" = "combine : copy_to_clipboard : clear_selection";
          "ctrl+shift+0" = "change_font_size all 0";
        };

        font = lib.mkForce {
          name = "Hack Nerd Font Mono";
          size = 11.5;
        };

        settings = {
          shell = lib.getExe config.programs.fish.package;
          enabled_layouts = "splits:split_axis=auto";
          window_padding_width = "0 10";
          confirm_os_window_close = 0;
          copy_on_select = "no";
          cursor_shape = "beam";
        };
      };
    };
}
