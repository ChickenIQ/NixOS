{
  flake.nixosModules.preservation =
    { inputs, self, ... }:
    {
      imports = [ inputs.preservation.nixosModules.preservation ];
      preservation.enable = true;

      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
      fileSystems.${self.meta.persistence.directory}.neededForBoot = true;

      persistence = {
        commonMountOptions = [
          "x-gvfs-hide"
          "x-gdu.hide"
        ];

        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];

        directories = [
          "/var/lib/systemd/timers"
          "/var/lib/nixos"
          "/var/cache"
          "/var/log"
        ];
      };
    };
}
