{ self, ... }:
{
  flake.hosts."box-0" =
    { config, ... }:
    {
      users.users.${config.vars.user.name}.linger = true;
      systemd.services."user@${toString config.users.users.${config.vars.user.name}.uid}" = {
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
      };

      home =
        { pkgs, lib, ... }:
        let
          mkService = name: command: {
            Install.WantedBy = [ "default.target" ];
            Service =
              let
                tmux = "${lib.getExe pkgs.tmux} -L ${name}";
              in
              {
                ExecStart = "${tmux} new-session -d -s ${name} -c %h/claude ${command}";
                ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/claude";
                Environment = "DISCORD_ACCESS_MODE=static";
                ExecStop = "${tmux} kill-server";
                Restart = "always";
                RestartSec = "5s";
                Type = "forking";
              };
          };
        in
        {
          imports = [ self.homeModules.claude-code ];

          programs.claude-code.settings = {
            enabledPlugins."discord@claude-plugins-official" = true;
            skipDangerousModePermissionPrompt = true;
          };

          home.packages = with pkgs; [
            python3
            ripgrep
            unzip
            curl
            wget
            tmux
            tree
            file
            bun
            git
            jq
            fd
            gh
          ];

          home.file."claude/CLAUDE.md".text = ''
            * You run on a headless NixOS server as a systemd user service with passwordless sudo.
            * Your services are `claude-discord` and `claude-rc`; manage them with `systemctl --user`.
            * Restarting `claude-discord` starts a fresh Discord session.
          '';

          home.file.".claude/channels/discord/access.json".text = builtins.toJSON {
            allowFrom = [ "601708809798549536" ];
            dmPolicy = "allowlist";
          };

          systemd.user.services = {
            claude-discord = mkService "discord" "claude --dangerously-skip-permissions --channels plugin:discord@claude-plugins-official";
            claude-rc = mkService "rc" "claude remote-control --name box --permission-mode bypassPermissions";
          };
        };
    };
}
