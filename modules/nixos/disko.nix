{
  flake.nixosModules.disko =
    { inputs, self, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];
      services.btrfs.autoScrub.enable = true;

      disko.devices.disk.main = {
        device = "/dev/diskoTarget";
        imageSize = "24G";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "4096M";
              type = "EF00";
              content = {
                format = "vfat";
                type = "filesystem";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            system.content = {
              type = "btrfs";
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "${self.meta.persistence.name}" = {
                  mountpoint = self.meta.persistence.directory;
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
              };
            };
          };
        };
      };
    };
}
