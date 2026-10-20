{
  perSystem =
    { lib, pkgs, ... }:
    {
      packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isx86_64 {
        helium = pkgs.appimageTools.wrapType2 rec {
          pname = "helium";
          version = "0.19.4.1";
          dieWithParent = false;

          src = pkgs.fetchurl {
            url = "https://github.com/imputnet/helium-linux/releases/download/${version}/${pname}-${version}-x86_64.AppImage";
            hash = "sha256-Wy2zkrPth/JKqESTYFnWisqYvCBUjqqg3s+jwoCioKc=";
          };

          extraInstallCommands =
            let
              contents = pkgs.appimageTools.extract { inherit pname version src; };
            in
            ''
              install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
              substituteInPlace $out/share/applications/${pname}.desktop \
                --replace-warn 'Exec=AppRun' 'Exec=${pname}'
              cp -r ${contents}/usr/share/icons $out/share
            '';

          passthru.updateScript = pkgs.nix-update-script { extraArgs = [ "--flake" ]; };
        };
      };
    };
}
