{ pkgs, ... }:
{
  programs = {
    gh.enable = true;
    git.enable = true;
    btop.enable = true;
    vscode.enable = true;
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
    sops
    blender

    # IDEs
    jetbrains.idea
    jetbrains.clion

    # Nix
    nixd
    nixfmt

    # JS/TS
    nodePackages.nodejs

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
    talosctl
    vcluster
    kubelogin-oidc
    kubernetes-helm
  ];
}
