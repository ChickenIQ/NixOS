{ pkgs, ... }:
{
  home.packages = with pkgs.unstable; [
    discord-canary
    mangohud
  ];

  services.flatpak = {
    remotes."flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";

    packages =
      let
        mkApp = pkg: "flathub:app/${pkg}/x86_64/stable";
      in
      builtins.map mkApp [
        "org.prismlauncher.PrismLauncher"
        "io.gitlab.librewolf-community"
        "at.vintagestory.VintageStory"
        "org.qbittorrent.qBittorrent"
        "com.heroicgameslauncher.hgl"
        "md.obsidian.Obsidian"
        "com.stremio.Stremio"
        "org.vinegarhq.Sober"
        "com.spotify.Client"
      ];

    overrides = {
      "com.stremio.Stremio".Environment.QSG_RENDER_LOOP = "threaded";
      "org.vinegarhq.Sober".Context.devices = "input";
    };
  };
}
