{ self, ... }:
{
  flake.hosts."g15".imports = with self.nixosModules; [
    bluetooth
    nvidia
    intel
  ];
}
