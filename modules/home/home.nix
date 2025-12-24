{ inputs, ... }:
{
  imports = with inputs; [
    nvf.homeManagerModules.default
    flatpak.homeModules.default
  ];
}
