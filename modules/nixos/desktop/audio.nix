{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    extraConfig.pipewire."99-input-denoising"."context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling Source";
          "media.name" = "Noise Canceling Source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = 85.0;
                  "VAD Grace Period (ms)" = 200;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "audio.position" = [ "MONO" ];
            "node.passive" = true;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "audio.position" = [ "MONO" ];
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
}
