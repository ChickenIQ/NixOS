{
  flake.nixosModules.disko =
    { inputs, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];
      services.btrfs.autoScrub.enable = true;

      disko.devices.disk.main = {
        device = "/dev/diskoTarget";
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

                "data" = {
                  mountpoint = "/data";
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
