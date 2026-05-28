{ config, pkgs, ... }:
let
  replayNotify = pkgs.writeShellApplication {
    name = "replay-notify";

    runtimeInputs = with pkgs; [
      libnotify
      sox
    ];

    text = ''
      if [ -f "$1" ] && [ "$2" = "replay" ]; then
        notify-send -e "GPU Screen Recorder" "Replay saved successfully!"
        play -qn synth .07 sine C4 fade h .004 .07 .03 gain -16
        play -qn synth .1 sine G4 fade h .004 .1 .045 gain -17
      fi
    '';
  };

  saveReplay = pkgs.writeShellApplication {
    name = "gpu-screen-recorder-save-replay";

    runtimeInputs = with pkgs; [
      libnotify
      systemd
      sox
    ];

    text = ''
      if ! systemctl --user kill -s SIGUSR1 --kill-who=main gpu-screen-recorder-replay; then
        notify-send -e "GPU Screen Recorder" "Failed to save replay!"
        play -qn synth .065 sine E4 fade h .005 .065 .028 gain -18
        play -qn synth .105 sine F4 fade h .005 .105 .048 gain -18 
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
      Description = "GPU Screen Recorder Replay Service";
      PartOf = [ "graphical-session.target" ];
      After = [ "pipewire.service" ];
    };

    Service = {
      Restart = "on-failure";
      RestartSec = "5s";
      ExecStart = ''
        ${pkgs.gpu-screen-recorder}/bin/gpu-screen-recorder \
          -w screen -r 60 -c mp4 -k av1 -fm cfr -bm cbr -q 40000 \
          -o ${config.home.homeDirectory}/Videos/Replays \
          -sc ${replayNotify}/bin/replay-notify \
          -a "default_output|rnnoise_source" \
          -a "default_output" \
          -a "rnnoise_source"
      '';
    };
  };
}
