{
  flake.homeModules.mangohud = {
    programs.mangohud = {
      enable = true;
      settings.preset = 0;
      enableSessionWide = true;
    };
  };
}
