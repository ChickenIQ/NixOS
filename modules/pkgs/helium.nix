{
  perSystem =
    { lib, pkgs, ... }:
    {
      packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isx86_64 {
        helium = pkgs.appimageTools.wrapType2 rec {
          pname = "helium";
          version = "0.16.4.1";
          dieWithParent = false;

          src = pkgs.fetchurl {
            url = "https://github.com/imputnet/helium-linux/releases/download/${version}/${pname}-${version}-x86_64.AppImage";
            hash = "sha256-z0OoKmW49F/2F3mxjZlyJsTY45keyZJAj4pjoGBjBO8=";
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
        };
      };
    };
}
