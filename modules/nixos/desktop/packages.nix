{ pkgs, ... }:
{
  services = {
    bpftune.enable = true;
    flatpak.enable = true;
    lact.enable = true;

    sunshine = {
      enable = true;
      capSysAdmin = true;
      openFirewall = true;
      settings.capture = "kwin";
    };

    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };

    openssh = {
      settings.PasswordAuthentication = false;
      enable = true;
    };
  };

  programs = {
    nix-index-database.comma.enable = true;
    gpu-screen-recorder.enable = true;
    gamescope.enable = true;
    gamemode.enable = true;
    nix-ld.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    steam = {
      enable = true;
      extraPackages = with pkgs; [ kdePackages.breeze ];
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
      package = pkgs.steam.override { extraArgs = "-silent steam://open/main"; };
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
    kdiskmark
    sbctl
    rar
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts-color-emoji
    nerd-fonts.hack
    liberation_ttf
    vista-fonts
    noto-fonts
    corefonts
  ];
}
