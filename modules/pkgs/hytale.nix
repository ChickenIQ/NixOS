{
  perSystem =
    { pkgs, ... }:
    {
      packages.hytale = pkgs.stdenvNoCC.mkDerivation {
        pname = "hytale";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-A0SZ5d2LNYPsuDsjOgvotGTZe8F56GOL4oWTkNNg7nQ=";
        };

        installPhase = "cp $src $out";
        dontUnpack = true;
        dontFixup = true;

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
