{
  perSystem =
    { pkgs, ... }:
    {
      packages.oniri = pkgs.rustPlatform.buildRustPackage rec {
        pname = "oniri";
        version = "1.3.5";
        cargoHash = "sha256-aqFIF5DemmKZs5rTF9c8mFts5emCmeNk5UYEKCl5ilQ=";

        src = pkgs.fetchFromGitHub {
          repo = "oniri";
          owner = "Antiz96";
          tag = "v${version}";
          hash = "sha256-BT5KVE5zT2z4gO2GLYV+ZtCQ8e9nUegxOnhkoywnrDo=";
        };

        meta = {
          description = "Automatically maximize the only window of a niri workspace";
          homepage = "https://github.com/Antiz96/oniri";
          license = pkgs.lib.licenses.gpl3Plus;
          mainProgram = "oniri";
        };
      };
    };
}
