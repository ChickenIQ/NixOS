{
  flake.homeModules.claude-code =
    { pkgs, ... }:
    {
      programs.claude-code = {
        enable = true;
        package = pkgs.unstable.claude-code;

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
          * Don't suggest tests, they are not needed is most cases.
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
