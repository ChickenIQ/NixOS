{ pkgs, ... }:
{
  programs = {
    gh.enable = true;
    git.enable = true;
    btop.enable = true;
    vscode = {
      enable = true;
      package = pkgs.unstable.vscode;
    };

    zed-editor = {
      enable = true;
      package = pkgs.unstable.zed-editor;
    };

    fish = {
      shellInitLast = ''
        kubectl completion fish | source
        talosctl completion fish | source
      '';

      shellAliases = {
        k = "kubectl";
        t = "talosctl";
        kns = "kubens";
        kctx = "kubectx";
      };
    };
  };

  home.packages = with pkgs.unstable; [
    # General
    gcc
    sops
    gnumake
    opencode

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
}
