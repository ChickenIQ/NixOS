{ pkgs, ... }:

{
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    extraLadspaPackages = [
      (pkgs.callPackage ./_package.nix { })
      pkgs.rnnoise-plugin
    ];
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
                "name" = "khip";
                "label" = "khip_ladspa";
                "plugin" = "libkhip_ladspa";
                "control"."Attenuation" = 1.0;
              }
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "librnnoise_ladspa";
                "label" = "noise_suppressor_mono";
                "control" = {
                  "VAD Threshold (%)" = 95.0;
                  "VAD Grace Period (ms)" = 0;
                  "Retroactive VAD Grace (ms)" = 0;
                };
              }
            ];
            "links" = [
              {
                "output" = "khip:Output";
                "input" = "rnnoise:Input";
              }
            ];
          };
          "capture.props" = {
            "node.name" = "capture.rnnoise_source";
            "audio.position" = [ "MONO" ];
            "node.passive" = true;
            "audio.channels" = 1;
            "audio.rate" = 48000;
          };
          "playback.props" = {
            "audio.position" = [ "MONO" ];
            "node.name" = "rnnoise_source";
            "media.class" = "Audio/Source";
            "audio.channels" = 1;
            "audio.rate" = 48000;
          };
        };
      }
    ];
  };
}
