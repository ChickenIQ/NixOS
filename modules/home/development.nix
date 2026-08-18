{
  flake.homeModules.development =
    { pkgs, ... }:
    {
      home = {
        shellAliases = {
          k = "kubectl";
          t = "talosctl";
        };

        packages = with pkgs.unstable; [
          # General
          git
          gcc
          sops
          vscode
          gnumake

          # IDEs
          jetbrains.idea
          jetbrains.clion
          jetbrains.goland

          # Nix
          nixd
          nixfmt

          # Go
          go
          gopls
          delve

          # K8s
          fluxcd
          kubectl
          talosctl
          kubelogin-oidc
          kubernetes-helm
        ];
      };
    };
}
