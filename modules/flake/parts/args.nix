{ inputs, self, ... }:
{
  perSystem =
    {
      inputs',
      system,
      self',
      ...
    }:
    {
      _module.args.specialArgs = {
        inherit
          self
          self'
          inputs
          inputs'
          ;
      };

      _module.args.pkgs = import inputs.nixpkgs {
        config.allowUnfree = true;
        inherit system;
        overlays = [
          (_: _: { self = self'.packages; })
          (final: _: {
            unstable = import inputs.nixpkgs-unstable {
              inherit (final.stdenv.hostPlatform) system;
              inherit (final) config;
            };
          })
        ];
      };
    };
}
