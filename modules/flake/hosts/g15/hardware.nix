{
  flake.hosts."g15" =
    { pkgs, ... }:
    {
      hardware.nvidia.powerManagement.enable = true;
      services.thermald.enable = true;

      boot.extraModprobeConfig = ''
        options snd-hda-intel model=dell-headset-multi
        options snd-hda-core gpu_bind=0
      '';

      environment.etc."alsa-card-profile/mixer/paths/analog-input-headset-mic.conf".text =
        let
          path = "share/pulseaudio/alsa-mixer/paths/analog-input-headset-mic.conf";
          cfg = builtins.readFile "${pkgs.pulseaudio}/${path}";
        in
        builtins.replaceStrings [ "priority = 88" ] [ "priority = 90" ] cfg;
    };
}
