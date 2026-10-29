{
  flake.nixosModules.preservation =
    {
      inputs,
      lib,
      ...
    }:

    {
      imports = [
        (lib.mkAliasOptionModule [ "persistence" ] [ "preservation" "preserveAt" "main" ])
        inputs.preservation.nixosModules.preservation
      ];

      preservation = {
        enable = true;
        preserveAt.main = {
          persistentStoragePath = "/data";

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

      fileSystems."/data".neededForBoot = true;
      systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
    };
}
