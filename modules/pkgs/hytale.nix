{
  perSystem =
    { pkgs, ... }:
    {
      packages.hytale = pkgs.stdenvNoCC.mkDerivation {
        pname = "hytale";
        version = "latest";

        src = pkgs.fetchurl {
          url = "https://launcher.hytale.com/builds/release/linux/amd64/hytale-launcher-latest.flatpak";
          hash = "sha256-7pjDqC5YIw9sk/FxkPzGdE+d4EnS+PNIVjq3bYB3pkI=";
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
