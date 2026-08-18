{
  flake.nixosModules.preservation =
    {
      inputs,
      self,
      lib,
      ...
    }:

    {
      imports = [
        inputs.preservation.nixosModules.preservation
        (lib.mkAliasOptionModule
          [ "persistence" ]
          [ "preservation" "preserveAt" self.meta.persistence.name ]
        )
      ];

      preservation = {
        enable = true;
        preserveAt.${self.meta.persistence.name} = {
          persistentStoragePath = self.meta.persistence.directory;

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

      fileSystems.${self.meta.persistence.directory}.neededForBoot = true;
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
