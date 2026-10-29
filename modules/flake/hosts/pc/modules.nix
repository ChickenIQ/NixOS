{ self, ... }:
{
  flake.hosts."pc".imports = with self.nixosModules; [
    self.profiles.desktop
    gsr-replays
    bluetooth
    sunshine
    libvirt
    # ollama
    amd
  ];
}
