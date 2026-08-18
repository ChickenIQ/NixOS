{ inputs, ... }:
{
  imports = [ inputs.home-manager.flakeModules.home-manager ];
  systems = [
    "aarch64-linux"
    "x86_64-linux"
  ];

  perSystem =
    { pkgs, ... }:
    {
      formatter = pkgs.writeShellApplication {
        name = "nixfmt-tree";
        runtimeInputs = [ pkgs.nixfmt-tree ];
        text = ''exec treefmt --tree-root "$PWD" "$@"'';
      };
    };
}
