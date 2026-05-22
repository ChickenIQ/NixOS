{ pkgs, ... }:
{
  home.packages = with pkgs; [
    moonlight-qt
    mangohud
    discord
    spotify
  ];

  services.flatpak = {
    remotes."flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";

    packages =
      let
        mkApp = pkg: "flathub:app/${pkg}/x86_64/stable";
        hytale = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-/S40Za4Rzro6NiH9vqnqo1UuuSbOspOk6MBoCSw8GLg=";
        };
      in
      (map mkApp [
        "org.prismlauncher.PrismLauncher"
        "io.gitlab.librewolf-community"
        "org.onlyoffice.desktopeditors"
        "at.vintagestory.VintageStory"
        "org.qbittorrent.qBittorrent"
        "com.heroicgameslauncher.hgl"
        "com.teamspeak.TeamSpeak"
        "com.obsproject.Studio"
        "md.obsidian.Obsidian"
        "com.stremio.Stremio"
        "org.vinegarhq.Sober"
        "org.videolan.VLC"
      ])
      ++ [ ":${hytale}" ];

    overrides = {
      "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
      "org.vinegarhq.Sober".Context.devices = "input";
    };
  };
}
