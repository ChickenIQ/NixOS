{
  perSystem =
    { pkgs, ... }:
    {
      packages.winreboot = pkgs.writeShellApplication {
        name = "winreboot";

        runtimeInputs = with pkgs; [
          efibootmgr
          systemd
          gawk
        ];

        text = ''
          entry="$(efibootmgr | awk '/Windows Boot Manager/ { print substr($1, 5, 4); exit }')"

          if [[ -z "$entry" ]]; then
            echo "Windows Boot Manager entry not found" >&2
            exit 1
          fi

          efibootmgr --bootnext "$entry"
          systemctl reboot
        '';
      };
    };
}
