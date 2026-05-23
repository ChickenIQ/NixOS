{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "gpu-screen-recorder-save-replay";

      runtimeInputs = with pkgs; [
        libnotify
        procps
        sox
      ];

      text = ''
        if pkill -SIGUSR1 -f '/bin/.wrapped/gpu-screen-recorder'; then
          (play -q -n synth 0.07 sine C4 fade h 0.004 0.07 0.03 gain -16; sleep 0.025; play -q -n synth 0.10 sine G4 fade h 0.004 0.10 0.045 gain -17) >/dev/null 2>&1 &
          notify-send "GPU Screen Recorder" "Replay saved!"
        else
          (play -q -n synth 0.065 sine E4 fade h 0.005 0.065 0.028 gain -18; sleep 0.024; play -q -n synth 0.105 sine F4 fade h 0.005 0.105 0.048 gain -18) >/dev/null 2>&1 &
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
          -w screen -r 60 -c mp4 -k av1 -fm cfr -bm cbr -q 40000 \
          -o ${config.home.homeDirectory}/Videos/Replays \
          -a "default_output|rnnoise_source" \
          -a "default_output" \
          -a "rnnoise_source"'
      '';
    };
  };
}
