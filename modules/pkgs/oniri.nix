{
  perSystem =
    { pkgs, ... }:
    {
      packages.oniri = pkgs.rustPlatform.buildRustPackage rec {
        pname = "oniri";
        version = "1.3.4";
        cargoHash = "sha256-aoqtaLKGflXyg+l3f1MYSOqLJILhnY8gS8ttC0wB7iw=";

        src = pkgs.fetchFromGitHub {
          repo = "oniri";
          owner = "Antiz96";
          tag = "v${version}";
          hash = "sha256-kJTE873WwM9E8SCedACCDjTWJ4sdDsFOuIQw2KLHK5s=";
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
