{
  flake.hosts."box-0" =
    {
      inputs,
      config,
      lib,
      ...
    }:
    let
      agents = {
        hermes-0.net = "10.233.0";
        hermes-1 = {
          net = "10.233.1";
          instructions = "Always reply in Romanian.";
          settings = {
            tts.edge.voice = "ro-RO-AlinaNeural";
            stt.language = "ro";
          };
        };
      };

      mkAgent =
        name:
        {
          net,
          settings ? { },
          instructions ? "",
        }:
        {
          localAddress = "${net}.2";
          hostAddress = "${net}.1";
          privateNetwork = true;
          autoStart = true;
          bindMounts."/data" = {
            hostPath = "/data/hermes/${name}";
            isReadOnly = false;
          };

          config = {
            imports = [ inputs.hermes-agent.nixosModules.default ];

            networking.useHostResolvConf = false;
            networking.nameservers = [
              "1.1.1.1"
              "8.8.8.8"
            ];

            system.stateVersion = config.vars.stateVersion;
            nix.registry.nixpkgs.flake = inputs.nixpkgs;
            nix.settings.experimental-features = [
              "nix-command"
              "flakes"
            ];

            systemd.services.hermes-agent.serviceConfig.ReadWritePaths = [
              "/nix/var/nix/profiles/per-user/hermes"
              "/data"
            ];

            systemd.tmpfiles.rules = [
              "L+ /var/lib/hermes/.nix-profile - - - - /nix/var/nix/profiles/per-user/hermes/profile"
              "d /nix/var/nix/profiles/per-user/hermes 0755 hermes hermes -"
              "d /data 0700 hermes hermes -"
            ];

            services.hermes-agent = {
              workingDirectory = "/var/lib/hermes/workspace";
              environmentFiles = [ "/root/hermes.env" ];
              addToSystemPackages = true;
              enable = true;

              environment = {
                MATRIX_HOMESERVER = "https://matrix.org";
                MATRIX_MAX_MEDIA_BYTES = "1073741824";
                MATRIX_ENCRYPTION = "true";
                MATRIX_DEVICE_ID = name;
              };

              settings = lib.mkMerge [
                {
                  delegation.model = "claude-sonnet-5-5";
                  stt.local.model = "small";
                  approvals.mode = "off";
                  # probably haiku shouldn't be curator idk
                  # consolidator should be sonnet
                  # enable auto shit
                  auxiliary = lib.genAttrs [ "compression" "title_generation" "curator" "mcp" ] (_: {
                    model = "claude-haiku-5-5";
                    provider = "main";
                  });
                  model = {
                    base_url = "http://${net}.1:8317/v1";
                    key_env = "CLIPROXY_API_KEY";
                    default = "claude-opus-5-5";
                    provider = "custom";
                  };
                }
                settings
              ];

              documents."AGENTS.md" = ''
                # Tools

                You run on NixOS. There is no apt or pip.
                - One-off: `nix shell nixpkgs#<pkg> -c <cmd>`
                - Persistent: keep a flake at /var/lib/hermes/tools whose default package is a
                  `buildEnv` of your tools (input `nixpkgs.url = "nixpkgs"`). After editing it run
                  `nix profile upgrade --all` (first time: `nix profile install /var/lib/hermes/tools`).

                # Files

                Save anything the user wants to keep in /data.

                ${instructions}
              '';
            };
          };
        };
    in
    {
      systemd.tmpfiles.rules = lib.mapAttrsToList (name: _: "d /data/hermes/${name} - - - -") agents;
      networking.firewall.interfaces."ve-+".allowedTCPPorts = [ 8317 ];
      persistence.directories = [ "/var/lib/nixos-containers" ];
      containers = lib.mapAttrs mkAgent agents;
      networking.nat = {
        internalInterfaces = [ "ve-+" ];
        enable = true;
      };
    };
}
