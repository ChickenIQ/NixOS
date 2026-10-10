{
  flake.homeModules.zed =
    {
      config,
      self,
      lib,
      ...
    }:
    {
      stylix.targets.zed.enable = false;
      programs.zed-editor = {
        enable = true;
        mutableUserSettings = false;
        mutableUserKeymaps = false;

        extensions = [
          "colored-zed-icons-theme"
          "oxocarbon"
          "nix"
        ];

        userKeymaps = [
          { bindings."f4" = "workspace::NewCenterTerminal"; }
          {
            context = "Editor";
            bindings = {
              "ctrl-d" = "editor::DuplicateSelection";
              "ctrl-shift-d" = "editor::DeleteLine";
            };
          }
        ];

        userSettings = {
          icon_theme = "Colored Zed Icons Theme Dark";
          buffer_font_family = "JetBrainsMono NF";
          theme = "Oxocarbon Dark (Variant I)";
          collaboration_panel.button = false;
          buffer_font_features.calt = false;
          git.inline_blame.enabled = false;
          title_bar.show_sign_in = false;
          autosave = "on_focus_change";
          project_panel.dock = "left";
          format_on_save = "on";
          disable_ai = true;

          lsp.nixd.settings.options =
            let
              hostname = ''builtins.replaceStrings [ "\n" ] [ "" ] (builtins.readFile /etc/hostname)'';
              host = ''(builtins.getFlake "${self}").nixosConfigurations.''${${hostname}}.options'';
            in
            {
              nixos.expr = host;
              home-manager.expr = "${host}.home-manager.users.type.getSubOptions [ ]";
            };

          languages.Nix.language_servers = [
            "nixd"
            "!nil"
          ];

          terminal = {
            cursor_shape = "bar";
            shell.program = lib.getExe config.programs.fish.package;
          };

          telemetry = {
            diagnostics = false;
            metrics = false;
          };
        };
      };
    };
}
