{
  flake.homeModules.development =
    { pkgs, lib, ... }:
    {
      programs.fish.completions = lib.genAttrs [ "talosctl" "omnictl" ] (name: ''
        source ${builtins.getAttr name pkgs.unstable}/share/fish/vendor_completions.d/${name}.fish
      '');

      home = {
        shellAliases = {
          k = "kubectl";
          kns = "kubens";
          kctx = "kubectx";
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
          kubectx
          omnictl
          talosctl
          kubelogin-oidc
          kubernetes-helm
        ];
      };
    };
}
