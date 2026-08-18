{
  perSystem =
    { pkgs, ... }:
    {
      packages.oniri = pkgs.rustPlatform.buildRustPackage rec {
        pname = "oniri";
        version = "1.3.3";
        cargoHash = "sha256-mO0Q8Q2dTBhGCKQlhHSFzz8YHpH/MtYbCuH4PIVZPpw=";

        src = pkgs.fetchFromGitHub {
          repo = "oniri";
          owner = "Antiz96";
          tag = "v${version}";
          hash = "sha256-/rTE4EQ2GJlfeudWnM9Qh9lpDnGXM86Ilmquts6BHJM=";
        };

        patches = [ ./oniri.patch ];

        meta = {
          description = "Automatically maximize the only window of a niri workspace";
          homepage = "https://github.com/Antiz96/oniri";
          license = pkgs.lib.licenses.gpl3Plus;
          mainProgram = "oniri";
        };
      };
    };
}
