{
  flake.hosts."box-0" =
    { pkgs, lib, ... }:
    {
      boot.kernelModules = [ "dell-smm-hwmon" ];

      hardware.fancontrol = {
        enable = true;
        config = ''
          DEVPATH=hwmon1=devices/platform/PNP0C14:05/wmi_bus/wmi_bus-PNP0C14:05/F1DDEE52-063C-4784-A11E-8A06684B9B01-19 hwmon4=devices/platform/coretemp.0
          DEVNAME=hwmon1=dell_smm hwmon4=coretemp
          FCTEMPS=hwmon1/pwm1=hwmon4/temp1_input
          MINSTART=hwmon1/pwm1=255
          MINSTOP=hwmon1/pwm1=0
          MINTEMP=hwmon1/pwm1=84
          MAXTEMP=hwmon1/pwm1=85
          INTERVAL=2
        '';
      };

      systemd.services.fancontrol.serviceConfig =
        let
          bios = lib.getExe pkgs.dell-bios-fan-control;
        in
        {
          ExecStartPre = "${bios} 0";
          ExecStopPost = "${bios} 1";
        };
    };
}
