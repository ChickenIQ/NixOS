{
  perSystem =
    { pkgs, ... }:
    let
      gsr-notify = pkgs.writeShellApplication {
        name = "gsr-notify";

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

      gsr-save = pkgs.writeShellApplication {
        name = "gsr-save";

        runtimeInputs = with pkgs; [
          libnotify
          systemd
          sox
        ];

        text = ''
          if ! systemctl --user kill -s SIGUSR1 --kill-who=main gpu-screen-recorder; then
            notify-send -e "GPU Screen Recorder" "Failed to save replay!"
            play -qn synth .065 sine E4 fade h .005 .065 .028 gain -18
            play -qn synth .105 sine F4 fade h .005 .105 .048 gain -18
            exit 1
          fi
        '';
      };
    in
    {
      packages.gsr-tools = pkgs.symlinkJoin {
        name = "gsr-tools";
        paths = [
          gsr-notify
          gsr-save
        ];
      };
    };
}
