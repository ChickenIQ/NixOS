{
  flake.nixosModules.tools = { pkgs, ... }: {
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs.kdePackages; [
      kdegraphics-thumbnailers
      qtimageformats
      kimageformats
      ffmpegthumbs
      kio-extras
      dolphin
    ];
  };
}
