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
        omnictl completion fish | source
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
    sops
    blender
    gnumake

    # IDEs
    jetbrains.idea
    jetbrains.clion
    jetbrains.goland

    # Nix
    nixd
    nixfmt

    # C/C++
    gcc
    gdb

    # Go
    go
    gopls
    delve
    grpc-tools
    protoc-gen-go
    protoc-gen-go-grpc

    # K8s
    fluxcd
    kubectl
    kubectx
    omnictl
    talosctl
    vcluster
    kubelogin-oidc
    kubernetes-helm
  ];
}
