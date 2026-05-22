{ config, pkgs, ... }:

let
  replayDir = "${config.home.homeDirectory}/Videos/Replays";

  saveReplay = pkgs.writeShellApplication {
    name = "gpu-screen-recorder-save-replay";

    runtimeInputs = with pkgs; [
      libnotify
      procps
    ];

    text = ''
      if pkill -SIGUSR1 -f '/bin/.wrapped/gpu-screen-recorder'; then
        notify-send "GPU Screen Recorder" "Replay saved!" --urgency=low
      else
        notify-send "GPU Screen Recorder" "Failed to save replay!" --urgency=critical
        exit 1
      fi
    '';
  };
in
{
  home.packages = [ saveReplay ];

  systemd.user.services.gpu-screen-recorder-replay = {
    Install.WantedBy = [ "graphical-session.target" ];

    Unit = {
      Description = "GPU Screen Recorder replay buffer";
      PartOf = [ "graphical-session.target" ];
      After = [
        "graphical-session.target"
        "pipewire.service"
      ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p ${replayDir}";
      Restart = "on-failure";
      RestartSec = "3s";
      ExecStart = ''
        ${pkgs.bash}/bin/sh -c '${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder \
          -w screen \
          -r 60 \
          -c mp4 \
          -k av1 \
          -a "$(${pkgs.pulseaudio}/bin/pactl get-default-sink).monitor|rnnoise_source" \
          -o ${replayDir}'
      '';
    };
  };
}
