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
              mountOptions = [ "noatime" ];
              mountpoint = "/";
            };
            "nix" = {
              mountOptions = [ "noatime" ];
              mountpoint = "/nix";
            };
            "data" = {
              mountOptions = [ "noatime" ];
              swap.swapfile.size = "16G";
              mountpoint = "/data";
            };
            "home" = {
              mountOptions = [ "noatime" ];
              mountpoint = "/home";
            };
          };
        };
      };
    };
  };

  fileSystems."/data".neededForBoot = true;
  services.btrfs.autoScrub.enable = true;

  boot.initrd.systemd.services.reset-root = {
    requiredBy = [ "initrd.target" ];
    before = [ "sysroot.mount" ];

    unitConfig.DefaultDependencies = false;
    serviceConfig.Type = "oneshot";

    after = [
      "systemd-hibernate-resume.service"
      "initrd-root-device.target"
    ];

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
