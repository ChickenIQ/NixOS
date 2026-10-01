{
  flake.hosts."pc" =
    { pkgs, ... }:
    let
      pwm = percent: builtins.floor (percent * 255.0 / 100 + 0.5);
      fan = id: channel: curve: minPercent: maxPercent: {
        controlAlgorithm = "direct";
        minPwm = pwm minPercent;
        maxPwm = pwm maxPercent;
        neverStop = true;
        inherit id curve;
        hwmon = {
          platform = "nct6799-isa-0290";
          rpmChannel = channel;
          pwmChannel = channel;
        };
      };

      configFile = (pkgs.formats.yaml { }).generate "fan2go.yaml" {
        tempRollingWindowSize = 25;
        api.enabled = true;

        fans = [
          (fan "cpu" 1 "cpu_curve" 10 25)
          (fan "vrm" 2 "cpu_curve" 5 50)
          (fan "back" 3 "case_curve" 25 40)
          (fan "front" 4 "case_curve" 20 20)
          (fan "side" 5 "case_curve" 20 20)
          (fan "pump" 6 "cpu_curve" 25 50)
          (fan "under_gpu" 7 "gpu_curve" 5 10)
        ];

        sensors = [
          {
            id = "cpu_temp";
            hwmon = {
              platform = "k10temp-pci-00c3";
              index = 1;
            };
          }
          {
            id = "gpu_temp";
            hwmon = {
              platform = "amdgpu-pci-0300";
              index = 1;
            };
          }
        ];

        curves = [
          {
            id = "cpu_curve";
            linear = {
              sensor = "cpu_temp";
              min = 50;
              max = 85;
            };
          }
          {
            id = "gpu_curve";
            linear = {
              sensor = "gpu_temp";
              min = 50;
              max = 85;
            };
          }
          {
            id = "case_curve";
            function = {
              type = "maximum";
              curves = [
                "cpu_curve"
                "gpu_curve"
              ];
            };
          }
        ];
      };
    in
    {
      persistence.directories = [ "/var/lib/fan2go" ];

      environment = {
        etc."fan2go/fan2go.yaml".source = configFile;
        systemPackages = [ pkgs.fan2go ];
      };

      systemd.services.fan2go = {
        after = [ "systemd-modules-load.service" ];
        wantedBy = [ "multi-user.target" ];
        restartTriggers = [ configFile ];
        serviceConfig = {
          ExecStart = "${pkgs.fan2go}/bin/fan2go -c ${configFile}";
          StateDirectory = "fan2go";
          Restart = "on-failure";
          TimeoutStopSec = "5s";
          RestartSec = "5s";
        };
      };
    };
}
