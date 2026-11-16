{ self, ... }:
{
  flake.hosts."box-0" = {
    home =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {
        imports = [ self.homeModules.claude-code ];
        programs.claude-code.mutableSettings = true;

        systemd.user = {
          tmpfiles.rules = [ "d %h/claude - - -" ];
          services.claude-rc = {
            Install.WantedBy = [ "default.target" ];
            Service = {
              ExecStart = "${lib.getExe config.programs.claude-code.finalPackage} remote-control --name box --permission-mode bypassPermissions";
              WorkingDirectory = "%h/claude";
              Restart = "always";
              RestartSec = "5s";
            };
          };
        };

        home.packages = with pkgs; [
          python3
          ripgrep
          unzip
          curl
          wget
          tree
          file
          bun
          git
          jq
          fd
          gh
        ];
      };
  };
}
