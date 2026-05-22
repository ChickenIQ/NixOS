{ pkgs, lib, ... }:

let
  zen5Flags = "-march=znver5 -mtune=znver5";

  tuneMesa =
    mesa:
    mesa.overrideAttrs (old: {
      env = (old.env or { }) // {
        NIX_CFLAGS_COMPILE = zen5Flags;
      };
    });

  tuneKernel =
    kernel:
    pkgs.linuxPackagesFor (
      kernel.overrideAttrs (old: {
        makeFlags = (old.makeFlags or [ ]) ++ [
          "KCFLAGS=${zen5Flags}"
        ];
      })
    );
in
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = tuneMesa (pkgs.mesa);
    package32 = tuneMesa (pkgs.pkgsi686Linux.mesa);
  };

  boot.kernelPackages = lib.mkForce (tuneKernel (pkgs.linux_zen));
}
