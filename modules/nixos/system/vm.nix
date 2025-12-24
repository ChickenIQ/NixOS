{ config, lib, ... }:
{
  virtualisation.vmVariantWithDisko = {
    facter.reportPath = lib.mkForce null;

    systemd.services.create-home-dirs = {
      serviceConfig.Type = "oneshot";
      wantedBy = [ "basic.target" ];
      script =
        let
          users = lib.filterAttrs (n: u: u.isNormalUser && u.createHome) config.users.users;
          mkUsers = n: u: ''mkdir -p "${u.home}" && chown "${n}:${u.group}" "${u.home}"'';
        in
        lib.concatStringsSep "\n" (lib.mapAttrsToList mkUsers users);
    };

    virtualisation = {
      fileSystems = config.fileSystems;
      memorySize = 8192;
      cores = 4;
    };
  };
}
