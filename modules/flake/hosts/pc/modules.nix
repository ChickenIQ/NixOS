{ self, ... }:
{
  flake.hosts."pc".imports = with self.nixosModules; [
    gsr-replays
    bluetooth
    sunshine
    libvirt
    amd
  ];
}
