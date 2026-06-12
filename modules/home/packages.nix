{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    moonlight-qt
    mangohud
    mpv
  ];

  services.flatpak = {
    remotes."flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";

    packages =
      let
        mkApp = pkg: "flathub:app/${pkg}/x86_64/stable";
        hytale = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-8B4/DsQXhNyaFI7gTNsOaA3MTXpps9nk/YgLSVip6ms=";
        };
      in
      (map mkApp [
        "org.prismlauncher.PrismLauncher"
        "io.gitlab.librewolf-community"
        "org.onlyoffice.desktopeditors"
        "at.vintagestory.VintageStory"
        "org.qbittorrent.qBittorrent"
        "com.heroicgameslauncher.hgl"
        "com.discordapp.Discord"
        "com.obsproject.Studio"
        "md.obsidian.Obsidian"
        "com.stremio.Stremio"
        "org.vinegarhq.Sober"
        "com.spotify.Client"
        "org.kde.kdenlive"
      ])
      ++ [ ":${hytale}" ];

    overrides = {
      "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
      "com.discordapp.Discord".Context.filesystems = [ "home" ];
      "org.vinegarhq.Sober".Context.devices = "input";
    };
  };
}
