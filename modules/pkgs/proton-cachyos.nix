{
  perSystem =
    { pkgs, ... }:
    {
      packages.proton-cachyos = pkgs.proton-ge-bin.overrideAttrs (
        finalAttrs: old: {
          pname = "proton-cachyos";
          version = "11.0-20261014";
          steamDisplayName = "Proton-CachyOS";
          toolName = "proton-cachyos-${finalAttrs.version}-slr-x86_64_v3";

          src = pkgs.fetchzip {
            url = "https://github.com/CachyOS/proton-cachyos/releases/download/cachyos-${finalAttrs.version}-slr/${finalAttrs.toolName}.tar.xz";
            hash = "sha256-fHi/LfyvPj2qm8ma6JH+wEJiJO1Htwp6zkbdRSg6Xic=";
          };

          passthru = old.passthru // {
            updateScript = pkgs.nix-update-script {
              extraArgs = [
                "--version-regex=cachyos-(.*)-slr"
                "--flake"
              ];
            };
          };
        }
      );
    };
}
