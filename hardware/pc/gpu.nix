{ pkgs, ... }:
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

  virtualisation.libvirtd.hooks.qemu."gpu-passthrough" = pkgs.writeShellScript "libvirt-hooks-qemu" ''
    export PATH=$PATH:${pkgs.libvirt}/bin
    set -x

    start() {
      # Stop Services
      systemctl stop lactd.service display-manager.service user@1000.service

      # Unload GPU modules
      while ! modprobe -r amdgpu; do sleep 1; done

      # Unbind the GPU from display driver
      virsh nodedev-detach pci_0000_03_00_0
      virsh nodedev-detach pci_0000_03_00_1

      # Load VFIO Kernel Module
      modprobe vfio-pci
    }

    stop() {
      # Unload VFIO Kernel Module
      while ! modprobe -r vfio-pci; do sleep 1; done

      # Bind the GPU to display driver
      virsh nodedev-reattach pci_0000_03_00_0
      virsh nodedev-reattach pci_0000_03_00_1

      # Load GPU Modules
      modprobe amdgpu

      # Start Services
      systemctl start lactd.service display-manager.service
    }

    NAME="$1" HOOK="$2" STATE="$3"
    [[ $(echo "''${NAME##*-}" | tr '[:upper:]' '[:lower:]') != "gpu" ]] && exit 0
    [ "$HOOK" = "prepare" ] && [ "$STATE" = "begin" ] && start
    [ "$HOOK" = "release" ] && [ "$STATE" = "end" ] && stop
    exit 0
  '';
}
