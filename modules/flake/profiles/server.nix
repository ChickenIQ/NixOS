{ self, ... }:
{
  flake.profiles.server = {
    imports = [ self.profiles.base ];

    services.journald.settings.Journal.SystemMaxUse = "1G";
    fonts.fontconfig.enable = false;
    networking.useNetworkd = true;
    documentation.enable = false;
    boot.kernelParams = [
      "boot.panic_on_fail"
      "panic=1"
    ];
  };
}
