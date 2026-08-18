{
  flake.nixosModules.gsr-replays =
    {
      self,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.self.gsr-tools ];
      programs.gpu-screen-recorder.enable = true;

      systemd.user.services.gpu-screen-recorder = {
        description = "GPU Screen Recorder Replay Service";
        wantedBy = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        after = [ "pipewire.service" ];

        serviceConfig = {
          Restart = "on-failure";
          RestartSec = "5s";
          ExecStart = ''
            ${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder \
              -w screen -r 60 -c mp4 -k av1 -fm cfr -bm cbr -q 40000 \
              -o /home/${self.meta.user.name}/Videos/Replays \
              -sc ${pkgs.self.gsr-tools}/bin/gsr-notify \
              -a "default_output|rnnoise_source" \
              -a "default_output" \
              -a "rnnoise_source"
          '';
        };
      };
    };
}
