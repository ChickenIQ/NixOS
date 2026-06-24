{ pkgs, ... }:
{
  disko.devices.disk.main = {
    device = "/dev/diskoTarget";
    imageSize = "24G";
    content = {
      type = "gpt";
      partitions = {
        esp = {
          size = "5120M";
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

  fileSystems."/data".neededForBoot = true;
  services.btrfs.autoScrub.enable = true;

  boot.initrd.systemd.services.reset-root = {
    after = [ "initrd-root-device.target" ];
    unitConfig.DefaultDependencies = false;
    requiredBy = [ "initrd.target" ];
    serviceConfig.Type = "oneshot";
    before = [ "sysroot.mount" ];

    path = with pkgs; [
      util-linuxMinimal
      btrfs-progs
    ];

    script = ''
      mount -t btrfs /dev/disk/by-partlabel/disk-main-system /tmp
      btrfs subvolume delete --recursive /tmp/root
      btrfs subvolume create /tmp/root
    '';
  };
}
