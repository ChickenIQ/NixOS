{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    mangohud
    discord
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
        "at.vintagestory.VintageStory"
        "org.qbittorrent.qBittorrent"
        "com.heroicgameslauncher.hgl"
        "com.obsproject.Studio"
        "md.obsidian.Obsidian"
        "com.stremio.Stremio"
        "org.vinegarhq.Sober"
        "com.spotify.Client"
      ])
      ++ [ ":${hytale}" ];

    overrides = {
      "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
      "org.vinegarhq.Sober".Context.devices = "input";
    };
  };
}
