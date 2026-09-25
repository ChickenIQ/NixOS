{ self, ... }:
{
  perSystem =
    {
      inputs',
      pkgs,
      lib,
      ...
    }:
    let
      disko = pkgs.writeShellApplication {
        runtimeInputs = [ inputs'.disko.packages.disko ];
        name = "disko";

        text = ''
          action="$1"; host="$2"; disk="''${3:-}"

          case "$action" in
            format)
              [ -b "$disk" ] || exit 1
              mode="destroy,format,mount"
              ln -sf "$disk" /dev/diskoTarget
              ;;
            mount)
              mode="mount"
              ;;
            *)
              echo "Usage: disko {format|mount} <host> [disk]" >&2
              exit 1
              ;;
          esac

          disko --mode "$mode" --flake "${self}#$host"
        '';
      };

      installer = pkgs.writeShellApplication {
        name = "installer";
        runtimeInputs = [
          pkgs.nixos-install-tools
          disko
        ];

        text = ''
          host="$1" disk="''${2:-}"

          [ -z "$disk" ] || disko format "$host" "$disk"
          nixos-install --no-root-passwd --no-channel-copy --flake "${self}#$host"
        '';
      };
    in
    {
      apps = {
        installer.program = lib.getExe installer;
        disko.program = lib.getExe disko;
      };
    };
}
