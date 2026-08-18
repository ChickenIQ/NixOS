{
  flake.homeModules.gaming =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        faugus-launcher
        moonlight-qt
      ];

      services.flatpak = {
        packages = [
          {
            inherit (pkgs.self.hytale) appId;
            bundle = "${pkgs.self.hytale}";
          }
          "org.prismlauncher.PrismLauncher"
          "com.heroicgameslauncher.hgl"
          "org.vinegarhq.Sober"
        ];

        overrides."org.vinegarhq.Sober".Context.devices = "input";
      };
    };
}
