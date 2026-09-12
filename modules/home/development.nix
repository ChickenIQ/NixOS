{
  flake.homeModules.development =
    { pkgs, ... }:
    {
      home.packages = with pkgs.unstable; [
        # General
        git
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

        # IDEs
        pkgs.vscode
        jetbrains.idea
        jetbrains.clion
        jetbrains.goland
      ];
    };
}
