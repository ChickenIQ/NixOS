{
  flake.homeModules.opencode =
    { pkgs, lib, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        tui.theme = lib.mkForce "oxocarbon";

        context = ''
          # Global Instructions

          * Keep answers short, simple, and direct.
          * Do not explain reasoning unless asked.
          * Avoid repetition and unnecessary context.

          ## Code Changes

          * Make the smallest change that solves the problem well.
          * Prefer simple solutions over clever or over-engineered ones.
          * Do not refactor unrelated code.
          * Do not modify unrelated files.
          * Preserve the existing style and structure.
          * Do not add features I did not request.
          * Avoid unnecessary abstractions.
          * Use dependencies when they are reasonably popular, well-maintained, and provide a meaningful benefit to the project.
          * Prefer a good existing dependency over reimplementing substantial functionality from scratch.
          * Do not add dependencies for trivial functionality or marginal benefits.
          * Before adding, installing, or introducing any new dependency, briefly explain why it is useful and ask for my approval.
          * Do not add the dependency until I explicitly approve it.

          ## Environment

          * I use NixOS.
          * Docker is available.
          * Prefer Nix-native solutions for system-level changes.
          * Use Docker when it is the simpler or more appropriate option.

          Unless explicitly asked otherwise, optimize for minimal code changes, simple implementations, and short responses.
        '';

        settings.permission.external_directory = {
          "/etc/profiles/per-user/**" = "allow";
          "/run/current-system/**" = "allow";
          "/nix/store/**" = "allow";
        };
      };
    };
}
