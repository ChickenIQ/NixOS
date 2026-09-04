{
  flake.homeModules.umbriel =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      noctalia = cmd: "${lib.getExe config.programs.noctalia.package} msg ${cmd}";
      flatpak = app: "flatpak run ${app}";
    in
    {
      programs.umbriel = {
        enable = true;
        settings.keybinds = {
          "Mod+Shift+S" = "spawn:${noctalia "screenshot-region"}";
          "Print" = "spawn:${noctalia "screenshot-region"}";

          "XF86AudioLowerVolume" = "spawn:${noctalia "volume-down"}";
          "XF86AudioRaiseVolume" = "spawn:${noctalia "volume-up"}";
          "XF86AudioMute" = "spawn:${noctalia "volume-mute"}";
          "XF86AudioMicMute" = "spawn:${noctalia "mic-mute"}";

          "XF86AudioPrev" = "spawn:${noctalia "media previous"}";
          "XF86AudioPlay" = "spawn:${noctalia "media toggle"}";
          "XF86AudioStop" = "spawn:${noctalia "media stop"}";
          "XF86AudioNext" = "spawn:${noctalia "media next"}";

          "Mod+Right" = "window-focus-right";
          "Mod+Left" = "window-focus-left";
          "Mod+Down" = "workspace-next";
          "Mod+Up" = "workspace-previous";

          "Mod+Ctrl+WheelDown" = "window-move-to-workspace-next";
          "Mod+Ctrl+WheelUp" = "window-move-to-workspace-previous";
          "Mod+Shift+Right" = "column-move-right";
          "Mod+Shift+Left" = "column-move-left";

          "Mod+Shift+WheelDown" = "workspace-next";
          "Mod+Shift+WheelUp" = "workspace-previous";

          "Mod+Shift+Down" = "window-move-to-workspace-next";
          "Mod+Shift+Up" = "window-move-to-workspace-previous";
          "Mod+Bracketright" = "window-modify-width:0.1";
          "Mod+Bracketleft" = "window-modify-width:-0.1";

          "Mod+Shift+F" = "window-toggle-fullscreen";
          "Mod+Ctrl+F" = "window-toggle-floating";
          "Mod+F" = "window-toggle-maximize";

          "Mod+R" = "window-cycle-width";
          "Mod+Q" = "window-close";

          "Alt+Shift+Tab" = "window-focus-previous";
          "Alt+Tab" = "window-focus-next";
          "Mod+Tab" = {
            action = "overview-toggle";
            repeat = false;
          };

          "Mod+Space" = "spawn:${noctalia "panel-toggle launcher"}";
          "Mod+V" = "spawn:${noctalia "panel-toggle clipboard"}";
          "Mod+L" = "spawn:${noctalia "session lock"}";

          "Mod+Return" = "spawn:${lib.getExe config.programs.kitty.package}";
          "Mod+Insert" = "spawn:${lib.getExe' pkgs.self.gsr-tools "gsr-save"}";
          "Mod+E" = "spawn:${lib.getExe pkgs.kdePackages.dolphin}";
          "Mod+C" = "spawn:${flatpak "com.discordapp.Discord"}";
          "Mod+W" = "spawn:${lib.getExe pkgs.self.helium}";
        };
      };
    };
}
