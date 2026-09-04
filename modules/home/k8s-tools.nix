{
  flake.homeModules.k8s-tools =
    { pkgs, ... }:
    {
      home = {
        shellAliases = {
          kctx = "kubectx";
          kns = "kubens";
          k = "kubectl";
        };

        packages = with pkgs.unstable; [
          kubernetes-helm
          kubectl-linstor
          kubelogin-oidc
          cilium-cli
          kustomize
          talosctl
          kubectl
          omnictl
          kubectx
          argocd
          hubble
          velero
        ];
      };
    };
}
