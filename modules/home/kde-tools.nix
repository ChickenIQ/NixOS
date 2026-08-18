{
  flake.homeModules.kde-tools =
    { pkgs, ... }:
    {
      home.packages = with pkgs.kdePackages; [
        kdegraphics-thumbnailers
        qtimageformats
        kimageformats
        ffmpegthumbs
        kio-extras
        pkgs.qview
        dolphin
        kate
        ark
      ];

      xdg = {
        mimeApps.defaultApplications."inode/directory" = [ "org.kde.dolphin.desktop" ];
        desktopEntries."org.kde.kwrite" = {
          noDisplay = true;
          name = "KWrite";
        };
      };
    };
}
