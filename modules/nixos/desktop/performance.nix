{ pkgs, lib, ... }:
{
  zramSwap.enable = true;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    ananicy = {
      enable = true;
      package = pkgs.unstable.ananicy-cpp;
      extraRules = [ pkgs.unstable.ananicy-rules-cachyos ];
      settings = {
        check_freq = 15;
        apply_latnice = true;
        cgroup_realtime_workaround = lib.mkForce false;
      };
    };
    lact.enable = true;
    bpftune.enable = true;
  };
}
