{ pkgs, ... }:
{
  environment.variables.NIXOS_OZONE_WL = 1;
  programs.partition-manager.enable = true;

  services = {
    desktopManager.plasma6.enable = true;
    displayManager = {
      autoLogin.user = "emi";
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    khelpcenter
    kwin-x11
    discover
    aurorae
    okular
    elisa
    krdp
  ];
}
