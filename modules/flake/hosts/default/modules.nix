{ self, ... }:
{
  flake.hosts."default" = {
    home-manager.users."${self.meta.user.name}".imports = with self.homeModules; [
      development
      k8s-tools
      kde-tools
      noctalia
      programs
      opencode
      mangohud
      flatpak
      umbriel
      gaming
      stylix
      helium
      shell
      kitty
      nvim
    ];

    imports = with self.nixosModules; [
      network-manager
      preservation
      home-manager
      reset-root
      programs
      pipewire
      desktop
      netbird
      openssh
      podman
      limine
      kernel
      steam
      disko
      users
      nix
    ];
  };
}
