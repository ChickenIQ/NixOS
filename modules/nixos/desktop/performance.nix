{ pkgs, ... }:
{
  zramSwap.enable = true;

  services = {
    scx = {
      enable = true;
      scheduler = "scx_lavd";
    };
    ananicy = {
      enable = true;
      extraRules = [ pkgs.ananicy-rules-cachyos ];
    };
    lact.enable = true;
    bpftune.enable = true;
  };
}
