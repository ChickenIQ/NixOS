{
  perSystem =
    { pkgs, ... }:
    {
      packages.hytale = pkgs.stdenvNoCC.mkDerivation {
        pname = "hytale";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-2Zlebk51V1c6Yc7/bF5M3HfIid6GSIjfU5AY6KpXq8Q=";
        };

        dontUnpack = true;
        dontFixup = true;

        installPhase = ''
          cp $src $out
        '';

        passthru = {
          appId = "com.hypixel.HytaleLauncher";

          updateScript = pkgs.nix-update-script {
            extraArgs = [
              "--version=skip"
              "--flake"
            ];
          };
        };
      };
    };
}
