{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "gpu-screen-recorder-save-replay";

      runtimeInputs = with pkgs; [
        libnotify
        procps
      ];

      text = ''
        if pkill -SIGUSR1 -f '/bin/.wrapped/gpu-screen-recorder'; then
          notify-send "GPU Screen Recorder" "Replay saved!"
        else
          notify-send "GPU Screen Recorder" "Failed to save replay!"
          exit 1
        fi
      '';
    })
  ];

  systemd.user.services.gpu-screen-recorder-replay = {
    Install.WantedBy = [ "graphical-session.target" ];

    Unit = {
      Description = "GPU Screen Recorder replay buffer";
      PartOf = [ "graphical-session.target" ];
      After = [ "pipewire.service" ];
    };

    Service = {
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = ''
        ${pkgs.bash}/bin/sh -c '${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder \
          -a "$(${pkgs.pulseaudio}/bin/pactl get-default-sink).monitor|rnnoise_source" \
          -o ${config.home.homeDirectory}/Videos/Replays \
          -w screen -r 60 -c mp4 -k av1 -fm cfr'
      '';
    };
  };
}
