{ self, ... }:
{
  flake.hosts."default" = {
    home-manager.users."${self.meta.user.name}".imports = with self.homeModules; [
      development
      kde-tools
      noctalia
      programs
      opencode
      mangohud
      flatpak
      gaming
      helium
      stylix
      shell
      kitty
      niri
      nvim
    ];

    imports = with self.nixosModules; [
      network-manager
      display-manager
      preservation
      home-manager
      reset-root
      programs
      pipewire
      security
      netbird
      openssh
      limine
      kernel
      tuning
      steam
      disko
      users
      niri
      nix
    ];
  };
}
