{
  flake.nixosModules.utils =
    { pkgs, ... }:
    {
      services.udisks2.enable = true;
      environment.systemPackages = with pkgs; [
        killall
        ripgrep
        lsof
        tree
        dig
        rar
      ];
    };
}
