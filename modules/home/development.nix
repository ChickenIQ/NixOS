{
  flake.homeModules.development =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = "ChickenIQ";
            email = "emibenzar@gmail.com";
          };
          pull.rebase = true;
          init.defaultBranch = "main";
          url."git@github.com:".pushInsteadOf = "https://github.com/";
        };
      };

      home.packages = with pkgs.unstable; [
        # General
        gh
        gcc
        sops
        gnumake

        # Nix
        nixd
        nixfmt

        # Go
        go
        gopls
        delve

        # Rust
        rustup

        # Python
        python3

        # IDEs
        pkgs.vscode
        jetbrains.idea
        jetbrains.clion
        jetbrains.goland
      ];
    };
}
