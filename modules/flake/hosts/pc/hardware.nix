{
  flake.hosts."pc" =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.self.winreboot ];

      swapDevices = [ { device = "/dev/disk/by-partlabel/swap"; } ];
      systemd.sleep.settings.Sleep.AllowHibernation = "no";
      boot.zswap.enable = true;

      environment.etc."lact/config.yaml".text = ''
        version: 5

        daemon:
          log_level: info
          admin_group: wheel

        gpus:
          1002:7550-1DA2:E490-0000:03:00.0:
            voltage_offset: -70
            power_cap: 250.0
            
            performance_level: manual
            power_states:
              memory_clock: [2,3,4,5]

            fan_control_enabled: true
            fan_control_settings:
              mode: curve
              interval_ms: 500
              temperature_key: edge
              curve:
                65: 0.20
                70: 0.25
                75: 0.30
                80: 0.35
                85: 0.40
      '';
    };
}
