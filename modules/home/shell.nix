{ pkgs, ... }:
{
  home.packages = with pkgs; [
    eza
  ];

  programs = {
    starship.enable = true;
    fzf.enable = true;
    fish = {
      enable = true;
      shellAliases = {
        ls = "eza -a --color=auto --group-directories-first";
        vim = "nvim";
        v = "nvim";
      };

      interactiveShellInit = ''
        set fish_greeting
        bind \e\[1\;5A ""
        bind \e\[1\;5B ""
        bind \e\[3\;5~ kill-word
        bind \e\[1\;5F end-of-line
        bind \e\[1\;5H beginning-of-line
        bind \b backward-kill-path-component
      '';
    };
  };
}
