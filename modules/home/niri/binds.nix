{
  flake.homeModules.niri =
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
      programs.niri.settings.binds = {
        "Mod+Shift+S".action.screenshot.show-pointer = false;
        "Print".action.screenshot.show-pointer = false;

        "XF86AudioLowerVolume".action.spawn-sh = noctalia "volume-down";
        "XF86AudioRaiseVolume".action.spawn-sh = noctalia "volume-up";
        "XF86AudioMute".action.spawn-sh = noctalia "volume-mute";
        "XF86AudioMicMute".action.spawn-sh = noctalia "mic-mute";

        "XF86AudioPrev".action.spawn-sh = noctalia "media previous";
        "XF86AudioPlay".action.spawn-sh = noctalia "media toggle";
        "XF86AudioStop".action.spawn-sh = noctalia "media stop";
        "XF86AudioNext".action.spawn-sh = noctalia "media next";

        "Mod+Right".action.focus-window-down-or-column-right = [ ];
        "Mod+Left".action.focus-window-up-or-column-left = [ ];
        "Mod+Down".action.focus-workspace-down = [ ];
        "Mod+Up".action.focus-workspace-up = [ ];

        "Mod+Ctrl+WheelScrollDown".action.move-window-to-workspace-down = [ ];
        "Mod+Ctrl+WheelScrollUp".action.move-window-to-workspace-up = [ ];

        "Mod+WheelScrollDown".action.focus-window-down-or-column-right = [ ];
        "Mod+WheelScrollUp".action.focus-window-up-or-column-left = [ ];

        "Mod+Shift+WheelScrollDown".action.focus-workspace-down = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-workspace-up = [ ];

        "Mod+Shift+Down".action.move-window-to-workspace-down = [ ];
        "Mod+Shift+Up".action.move-window-to-workspace-up = [ ];
        "Mod+Shift+Right".action.move-column-right = [ ];
        "Mod+Shift+Left".action.move-column-left = [ ];

        "Mod+BracketRight".action.set-column-width = "+10%";
        "Mod+BracketLeft".action.set-column-width = "-10%";

        "Mod+Ctrl+F".action.toggle-window-floating = [ ];
        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+Tab".action.toggle-overview = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Q".action.close-window = [ ];

        "Mod+Space".action.spawn-sh = noctalia "panel-toggle launcher";
        "Mod+V".action.spawn-sh = noctalia "panel-toggle clipboard";
        "Mod+L".action.spawn-sh = noctalia "session lock";

        "Mod+Return".action.spawn = [ (lib.getExe config.programs.kitty.package) ];
        "Mod+Insert".action.spawn-sh = lib.getExe' pkgs.self.gsr-tools "gsr-save";
        "Mod+E".action.spawn = [ (lib.getExe pkgs.kdePackages.dolphin) ];
        "Mod+C".action.spawn-sh = flatpak "com.discordapp.Discord";
        "Mod+W".action.spawn = [ (lib.getExe pkgs.self.helium) ];
      };
    };
}
