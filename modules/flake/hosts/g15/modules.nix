{ self, ... }:
{
  flake.hosts."g15".imports = with self.nixosModules; [
    self.profiles.desktop
    bluetooth
    nvidia
    intel
  ];
}
