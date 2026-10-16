{
  flake.homeModules.opencode =
    { pkgs, lib, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        tui.theme = lib.mkForce "carbonfox";

        context = ''
          # Responses

          * Be short, simple, and direct.
          * No reasoning unless asked; no repetition or unnecessary context.

          # Code Changes

          * Make the smallest change that solves the problem well; prefer simple over clever.
          * Don't refactor unrelated code or modify unrelated files.
          * Match the author's style and structure: naming, formatting, idioms, patterns.
          * Order new lines by length where possible, longest first, otherwise shortest first.
          * Don't add unrequested features, tests, comments, docs, or abstractions.
          * Don't use `else`; prefer early returns.
          * Avoid changes that make the diff harder to review (reordering, reformatting, renaming) unless asked.

          # Dependencies

          * Use popular, well-maintained ones over reimplementing substantial functionality.
          * Not for trivial functionality or marginal benefits.
          * Explain why and get my approval before adding one.
          * When I ask for simplifications, suggest good dependencies that could help.

          # Environment

          * NixOS with Podman available.
          * Prefer Nix-native solutions for system-level changes; use Podman when simpler or more appropriate.
        '';

        settings.permission.external_directory = {
          "/etc/profiles/per-user/**" = "allow";
          "/run/current-system/**" = "allow";
          "/nix/**" = "allow";
        };
      };
    };
}
