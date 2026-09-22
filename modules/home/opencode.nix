{
  flake.homeModules.opencode =
    { pkgs, lib, ... }:
    {
      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        tui.theme = lib.mkForce "carbonfox";

        context = ''
          # Global Instructions

          * Keep answers short, simple, and direct.
          * Do not explain reasoning unless asked.
          * Avoid repetition and unnecessary context.
          * Prefer delegating non-trivial, self-contained work to the `luna` subagent. Keep trivial tasks local when delegation overhead would cost more.
          * Review and verify Luna's results before accepting them. If Lunaa fails or cannot complete the task, finish it with the primary agent.

          ## Code Changes

          * Make the smallest change that solves the problem well.
          * Prefer simple solutions over clever or over-engineered ones.
          * Do not refactor unrelated code.
          * Do not modify unrelated files.
          * Preserve the existing style and structure.
          * Do not add features I did not request.
          * Do not add tests unless I explicitly request them.
          * Avoid unnecessary abstractions.
          * Use dependencies when they are reasonably popular, well-maintained, and provide a meaningful benefit to the project.
          * Prefer a good existing dependency over reimplementing substantial functionality from scratch.
          * Do not add dependencies for trivial functionality or marginal benefits.
          * Before adding, installing, or introducing any new dependency, briefly explain why it is useful and ask for my approval.
          * Do not add the dependency until I explicitly approve it.

          ## Environment

          * I use NixOS.
          * Podman is available.
          * Prefer Nix-native solutions for system-level changes.
          * Use Podman when it is the simpler or more appropriate option.

          Unless explicitly asked otherwise, optimize for minimal code changes, simple implementations, and short responses.
        '';

        settings = {
          agent.luna = {
            description = ''
              Cost-efficient general-purpose worker, but not as capable as the primary agent.
              Prefer for simpler self-contained delegated tasks; the primary agent reviews its results and takes over if needed.
            '';
            model = "openai/gpt-6-luna";
            reasoningEffort = "high";
            mode = "subagent";
          };

          permission.external_directory = {
            "/etc/profiles/per-user/**" = "allow";
            "/run/current-system/**" = "allow";
            "/nix/**" = "allow";
          };
        };
      };
    };
}
