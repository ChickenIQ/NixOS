{
  flake.homeModules.programs =
    { pkgs, ... }:
    {
      programs.mpv.enable = true;
      xdg.mimeApps.enable = true;
      home.packages = with pkgs; [
        nvtopPackages.full
        self.helium
        fastfetch
        btop
      ];

      services.flatpak = {
        packages = [
          "org.onlyoffice.desktopeditors"
          "org.qbittorrent.qBittorrent"
          "com.discordapp.Discord"
          "com.obsproject.Studio"
          "com.stremio.Stremio"
          "com.spotify.Client"
          "org.kde.kdenlive"
        ];

        overrides = {
          "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
          "com.discordapp.Discord".Context.filesystems = [ "home" ];
        };
      };
    };
}
