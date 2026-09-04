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
        mimeApps = {
          defaultApplicationPackages = [ pkgs.qview ];
          defaultApplications = {
            "inode/directory" = [ "org.kde.dolphin.desktop" ];
            "application/x-jar" = [ "org.kde.ark.desktop" ];
            "text/plain" = [ "org.kde.kate.desktop" ];
          };
        };

        desktopEntries."org.kde.kwrite" = {
          noDisplay = true;
          name = "KWrite";
        };
      };
    };
}
