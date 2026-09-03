{
  perSystem =
    { pkgs, ... }:
    {
      packages.niri-tweaks = pkgs.stdenvNoCC.mkDerivation {
        version = "0-unstable-2026-09-01";
        pname = "niri-tweaks";

        passthru.updateScript = pkgs.nix-update-script {
          extraArgs = [
            "--version=branch"
            "--flake"
          ];
        };

        nativeBuildInputs = [
          pkgs.makeWrapper
          pkgs.python3
        ];

        src = pkgs.fetchFromGitHub {
          owner = "heyoeyo";
          repo = "niri_tweaks";
          rev = "74acb9d36bde9d777c5b2ba87d8302f00bfd8d42";
          hash = "sha256-Ojtvbdb0P+kfEcsfe17eXAcDGnV2eZ63+rQGAJcowyM=";
        };

        installPhase = ''
          mkdir -p $out/bin
          cp *.sh *.py $out/bin/
          chmod +x $out/bin/*

          patchShebangs $out/bin

          for script in $out/bin/*; do
            wrapProgram "$script" \
              --prefix PATH : ${
                pkgs.lib.makeBinPath [
                  pkgs.libnotify
                  pkgs.jq
                ]
              }
          done
        '';

        meta = {
          description = "Scripts for additional functionality in niri";
          homepage = "https://github.com/heyoeyo/niri_tweaks";
          platforms = pkgs.lib.platforms.linux;
        };
      };
    };
}
