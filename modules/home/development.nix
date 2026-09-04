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

        # IDEs
        vscode
        jetbrains.idea
        jetbrains.clion
        jetbrains.goland
      ];
    };
}
