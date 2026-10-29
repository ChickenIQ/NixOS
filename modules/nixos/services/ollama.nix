{
  flake.nixosModules.ollama =
    { pkgs, ... }:
    {
      services.ollama = {
        enable = true;
        package = pkgs.unstable.ollama-vulkan;

        environmentVariables = {
          OLLAMA_KV_CACHE_TYPE = "q4_0";
          OLLAMA_FLASH_ATTENTION = "1";
        };
      };

      environment.systemPackages = [
        (pkgs.unstable.alpaca.overridePythonAttrs (old: {
          dependencies = old.dependencies ++ [ pkgs.unstable.python3Packages.pandas ];
        }))
      ];

      persistence.directories = [ "/var/lib/private/ollama" ];
    };
}
