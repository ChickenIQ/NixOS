{
  hardware = {
    amdgpu.overdrive.enable = true;
    # Dummy Display for Sunshine
    display = {
      edid.modelines."Virt" = "565.22 1920 1988 2020 2120 1080 1098 1106 1112 +hsync -vsync";
      outputs."HDMI-A-2" = {
        edid = "Virt.bin";
        mode = "e";
      };
    };
  };

  environment.etc."lact/config.yaml".text = ''
    version: 5 
    current_profile: null

    daemon: 
      log_level: info 
      admin_group: wheel

    gpus:
      1002:7550-1DA2:E490-0000:03:00.0:
        power_cap: 250.0
        voltage_offset: -80
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
}
