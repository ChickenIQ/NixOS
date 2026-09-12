{
  perSystem =
    { pkgs, ... }:
    {
      packages.hytale = pkgs.stdenvNoCC.mkDerivation {
        pname = "hytale";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-OFyoQsUTjG6TDFXQVLAS9juQA4PabvE4z5hBKgSmhuI=";
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
