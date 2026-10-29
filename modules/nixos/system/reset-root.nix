{
  flake.nixosModules.reset-root =
    { pkgs, ... }:
    {
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
    };
}
