{ pkgs, ... }:
{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    extraLv2Packages = [ pkgs.lsp-plugins ];
    extraLadspaPackages = [ pkgs.rnnoise-plugin ];
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
                "plugin" = "librnnoise_ladspa";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = 90.0;
                  "VAD Grace Period (ms)" = 100;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
              {
                "type" = "lv2";
                "name" = "gate";
                "plugin" = "http://lsp-plug.in/plugins/lv2/gate_mono";
                "control" = {
                  "gh" = 1;
                  "shpm" = 2;
                  "shpf" = 150;
                  "at" = 5;
                  "rt" = 120;
                  "hold" = 80;
                  "gr" = 0.001;
                  "gt" = 0.006;
                  "ht" = 0.003;
                };
              }
            ];
            "links" = [
              {
                "output" = "rnnoise:Output";
                "input" = "gate:in";
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
