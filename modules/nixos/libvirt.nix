{
  flake.nixosModules.libvirt =
    {
      self,
      pkgs,
      lib,
      ...
    }:
    {
      programs.virt-manager.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        onBoot = "ignore";
        qemu = {
          swtpm.enable = true;
          vhostUserPackages = [ pkgs.virtiofsd ];
        };
      };

      boot = {
        kernelParams = [ "iommu=pt" ];
        kernelModules = [
          "vfio_iommu_type1"
          "vfio_pci"
          "vfio"
        ];
      };

      networking.firewall.extraCommands =
        let
          src = "192.168.122.0/24";
          dsts = [
            "10.0.0.0/8"
            "100.64.0.0/10"
            "172.16.0.0/12"
            "192.168.0.0/16"
          ];
        in
        lib.concatMapStringsSep "\n" (dst: "iptables -I FORWARD -s ${src} -d ${dst} -j DROP") dsts;

      persistence.directories = [ "/var/lib/libvirt" ];
      users.users.${self.meta.user.name}.extraGroups = [ "libvirtd" ];
      systemd.services.libvirtd.serviceConfig.LoadCredentialEncrypted = "";
    };
}
