{
  flake.homeModules.opencode =
    { pkgs, lib, ... }:
    let
      rule = action: effect: resource: { inherit action effect resource; };
    in
    {
      stylix.targets.opencode.enable = false;

      programs.opencode = {
        enable = true;
        package = pkgs.unstable.opencode;
        cli = {
          theme.name = lib.mkForce "carbonfox";
          session.sidebar = "hide";
          tabs.mode = "off";
        };

        context = ''
          # Responses

          * Be short, simple, and direct.
          * No reasoning unless asked; no repetition or unnecessary context.
          * Check before claiming something can't be done or a library doesn't have it.
          * Only call something fixed once the real failure case is tested; otherwise say it's a mitigation.

          # Code Changes

          * Make the smallest change that solves the problem well; prefer simple over clever.
          * Don't refactor unrelated code or modify unrelated files.
          * Match the author's style and structure: naming, formatting, idioms, patterns.
          * Order new lines by length where possible, longest first, otherwise shortest first.
          * Don't add unrequested features, tests, comments, docs, or abstractions.
          * Don't suggest tests, they are not needed is most cases.
          * Don't use `else`; prefer early returns.
          * Avoid changes that make the diff harder to review (reordering, reformatting, renaming) unless asked.
          * If a request has multiple plausible readings that change the code, ask first.
          * Implement only what was asked: no validation, fallbacks, migrations or edge-case handling unless asked. Mention risks in one line instead.
          * When simplifying, remove ideas (layers, params, types, packages, etc), don't just move code. Propose API changes that remove a lot, don't make them. Never report "nothing major" without listing what was considered.

          # Dependencies

          * Use popular, well-maintained ones over reimplementing substantial functionality.
          * Not for trivial functionality or marginal benefits.
          * Explain why and get my approval before adding one.
          * When I ask for simplifications, suggest good dependencies that could help.

          # Environment

          * NixOS with Podman available.
          * Prefer Nix-native solutions for system-level changes; use Podman when simpler or more appropriate.
        '';

        settings.permissions = [
          (rule "external_directory" "ask" "*")
          (rule "external_directory" "allow" "/etc/profiles/per-user/*")
          (rule "external_directory" "allow" "/run/current-system/*")
          (rule "external_directory" "allow" "/nix/*")
          (rule "external_directory" "allow" "/tmp/*")
          (rule "external_directory" "allow" "~/.rustup/*")
          (rule "external_directory" "allow" "~/.cargo/*")
          (rule "external_directory" "allow" "~/go/*")
          (rule "external_directory" "allow" "~/.local/share/opencode/tool-output/*")
          (rule "external_directory" "allow" "~/.local/share/opencode/shell/*")
        ];

        settings.policies = [
          (rule "integration.connect" "deny" "opencode-go")
          (rule "integration.connect" "deny" "opencode")
          (rule "provider.use" "deny" "opencode-go")
          (rule "provider.use" "deny" "opencode")
          (rule "skill.use" "deny" "report")
        ];

        settings.plugins = [ "-opencode.config.compatibility" ];

        settings.providers.claude-agent.models = {
          sonnet.limit.context = 1000000;
          haiku.limit.context = 100000;
          opus.limit.context = 1000000;
        };
      };
    };
}
