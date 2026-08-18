{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    faugus-launcher
    moonlight-qt
    mangohud
  ];

  programs.mpv.enable = true;

  services.flatpak = {
    uninstallUnmanaged = true;
    update.auto.enable = true;
    packages = [
      (rec {
        appId = "com.hypixel.HytaleLauncher";
        sha256 = "sha256-Fno5t0dztF23+/KldnSC2GYSmFbnGW3aFsZQdJ8HIfY=";
        bundle = "${pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = sha256;
        }}";
      })
      "org.prismlauncher.PrismLauncher"
      "io.gitlab.librewolf-community"
      "org.onlyoffice.desktopeditors"
      "org.qbittorrent.qBittorrent"
      "com.heroicgameslauncher.hgl"
      "com.discordapp.Discord"
      "com.obsproject.Studio"
      "md.obsidian.Obsidian"
      "com.stremio.Stremio"
      "org.vinegarhq.Sober"
      "com.spotify.Client"
      "org.kde.kdenlive"
    ];

    overrides = {
      "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
      "com.discordapp.Discord".Context.filesystems = [ "home" ];
      "org.vinegarhq.Sober".Context.devices = "input";
    };
  };
}
