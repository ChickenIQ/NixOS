{
  flake.homeModules.shell =
    { pkgs, ... }:
    {
      home = {
        shellAliases.ls = "eza -a --color=auto --group-directories-first";
        packages = with pkgs; [ eza ];
      };

      programs = {
        starship.enable = true;
        bash.enable = true;
        fzf.enable = true;
      };
    };
}
