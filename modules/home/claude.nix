{
  flake.homeModules.claude-code =
    { pkgs, ... }:
    {
      programs.claude-code = {
        enable = true;
        package = pkgs.unstable.claude-code;

        context = ''
          # Responses

          * Keep answers short, simple, and direct.
          * Do not explain reasoning unless asked.
          * Avoid repetition and unnecessary context.

          # Code Changes

          * Make the smallest change that solves the problem well.
          * Prefer simple solutions over clever or over-engineered ones.
          * Do not refactor unrelated code.
          * Do not modify unrelated files.
          * Preserve the existing style and structure.
          * Do not add features I did not request.
          * Do not add tests unless I explicitly request them.
          * Avoid unnecessary abstractions.
          * Use dependencies when they are reasonably popular, well-maintained, and provide a meaningful benefit.
          * Prefer a good existing dependency over reimplementing substantial functionality from scratch.
          * Do not add dependencies for trivial functionality or marginal benefits.
          * Before adding a dependency, explain why it is useful and ask for approval.
          * Do not add it until explicitly approved.
          * Do not add comments or documentation unless I explicitly request them.

          Unless explicitly asked otherwise, optimize for minimal code changes and simple implementations.

          # Environment

          * I use NixOS.
          * Podman is available.
          * Prefer Nix-native solutions for system-level changes.
          * Use Podman when it is simpler or more appropriate.
        '';

        settings = {
          preferredNotifChannel = "notifications_disabled";
          env.CLAUDE_CODE_IDE_SKIP_AUTO_INSTALL = "1";
          workflowKeywordTriggerEnabled = false;
          promptSuggestionEnabled = false;
          spinnerTipsEnabled = false;
          awaySummaryEnabled = false;
          model = "claude-opus-5-5";
          feedbackSurveyRate = 0;
          feedbackDrafts = "off";
          tui = "fullscreen";

          enabledPlugins = {
            "rust-analyzer-lsp@claude-plugins-official" = true;
            "gopls-lsp@claude-plugins-official" = true;
          };

          permissions.additionalDirectories = [
            "/etc/profiles/per-user"
            "/run/current-system"
            "/nix"
          ];
        };

      };
    };
}
