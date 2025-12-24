{ lib, ... }:
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

  environment.persistence."/data".hideMounts = true;
  fileSystems."/data".neededForBoot = true;

  boot.initrd.postResumeCommands = lib.mkAfter ''
    delete_subvolume() {
      IFS=$'\n'
      for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
        delete_subvolume "/temp/$i"
      done
      btrfs subvolume delete "$1"
    }
    mkdir /temp
    mount /dev/disk/by-partlabel/disk-main-system /temp
    [[ -e /temp/root ]] && delete_subvolume "/temp/root"
    btrfs subvolume create /temp/root
    umount /temp
  '';
}
