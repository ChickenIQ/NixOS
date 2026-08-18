{ self, ... }:
{
  flake.hosts."default" = {
    home-manager.users."${self.meta.user.name}".imports = with self.homeModules; [
      development
      kde-tools
      noctalia
      programs
      opencode
      flatpak
      gaming
      stylix
      shell
      kitty
      fish
      niri
      nvim
    ];

    imports = with self.nixosModules; [
      network-manager
      display-manager
      pipewire-noise
      package-compat
      preservation
      home-manager
      reset-root
      pipewire
      security
      netbird
      openssh
      limine
      kernel
      tuning
      utils
      steam
      disko
      users
      niri
      nix
    ];
  };
}
