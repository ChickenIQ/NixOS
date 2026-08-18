{
  flake.homeModules.stylix =
    { pkgs, ... }:
    {
      stylix.fonts.sizes.applications = 10;
      home.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
        nerd-fonts.hack
      ];
    };
}
