{ self, ... }:
{
  flake.profiles.desktop = {
    home.imports = with self.homeModules; [
      development
      claude-code
      kde-tools
      k8s-tools
      noctalia
      programs
      opencode
      flatpak
      umbriel
      gaming
      stylix
      helium
      kitty
      shell
      nvim
      zed
    ];

    imports = with self.nixosModules; [
      self.profiles.base
      network-manager
      peripherals
      secureboot
      programs
      pipewire
      session
      kernel
      gaming
      gpu
    ];
  };
}
