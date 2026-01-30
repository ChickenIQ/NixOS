{ pkgs, ... }:
{
  services = {
    flatpak.enable = true;
    sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    openssh = {
      settings.PasswordAuthentication = false;
      enable = true;
    };
  };

  programs = {
    nix-index-database.comma.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    nix-ld.enable = true;
    fuse.enable = true;

    steam = {
      enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };

    nh = {
      enable = true;
      flake = "/etc/nixos";
      clean = {
        enable = true;
        extraArgs = "--keep-since 7d --keep 3";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.full
    sbctl
  ];

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    liberation_ttf
    vista-fonts
    noto-fonts
    corefonts
  ];
}
