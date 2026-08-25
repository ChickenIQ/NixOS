{
  flake.homeModules.shell =
    { pkgs, ... }:
    {
      home = {
        shellAliases.ls = "eza -a --color=auto --group-directories-first";
        packages = [ pkgs.eza ];
      };

      programs = {
        starship.enable = true;
        bash.enable = true;
        fzf.enable = true;
        fish = {
          enable = true;
          functions.fish_greeting = "";
          binds = {
            "ctrl-up".command = "";
            "ctrl-down".command = "";
            "ctrl-delete".command = "kill-word";
            "ctrl-end".command = "end-of-line";
            "ctrl-home".command = "beginning-of-line";
            "ctrl-backspace".command = "backward-kill-path-component";
          };
        };
      };
    };
}
