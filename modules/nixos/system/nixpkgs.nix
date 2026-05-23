{ inputs, pkgs, ... }:
{
  nix = {
    channel.enable = false;
    optimise.automatic = true;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      (final: _: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (final.stdenv.hostPlatform) system;
          inherit (final) overlays config;
        };
      })
    ];
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nix-run" ''
      [ $# -ge 1 ] || { echo "usage: nix-run <package> [args...]" >&2; exit 2; }
      pkg="$1"; shift; export NIXPKGS_ALLOW_UNFREE=1

      exec nix run --impure "github:nixos/nixpkgs/nixpkgs-unstable#$pkg" -- "$@"
    '')
  ];
}
