{
  flake.homeModules.opencode =
    { pkgs, ... }:
    let
      common = ''
        # Global Instructions

        * Keep answers short, simple, and direct.
        * Do not explain reasoning unless asked.
        * Avoid repetition and unnecessary context.
        * Unless explicitly asked otherwise, optimize for minimal code changes, simple implementations, and short responses.

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
      '';

      opencode = ''
        # Task Completion

        * Prefer delegating non-trivial, self-contained work to Gemini.
        * Gemini runs in an isolated Podman container with its own root filesystem.
        * The target directory for the task is mounted into Gemini at /workspace.
        * Gemini has no access to other host paths unless explicitly mounted.
        * If Gemini's usage limit has been reached, delegate to the terra subagent instead.
        * Terra is not container-isolated and has the same host access available to the primary OpenCode agent.
        * Keep trivial tasks local when delegation overhead would cost more.
        * Review and verify delegated results before accepting them.
        * If the delegated agent fails or cannot complete the task, finish it with the primary agent.

        ## Environment

        * I use NixOS.
        * Podman is available.
        * Prefer Nix-native solutions for system-level changes.
        * Use Podman when it is the simpler or more appropriate option.
      '';

      gemini = ''
        # Task Completion

        * Run relevant checks before finishing.
        * Work only on the delegated task given by the primary agent.
        * Report relevant results, blockers, and remaining issues to the primary agent.
        * Make changes directly in /workspace, do not use it for temporary files or other purposes.
        * Do not add new dependencies unless the delegated task explicitly says they were approved.
        * If a new dependency is required but not approved, report that to the primary agent instead of installing it.

        ## Environment

        * You are in a Debian container with root access and internet access.
        * You may install temporary system tooling needed to complete the task.
        * Everything is ephemeral except /workspace, which is the user's persistent working directory.
      '';

      geminiPrompt = pkgs.writeText "GEMINI.md" "${common}\n\n${gemini}";
    in
    {
      programs.opencode = {
        context = "${common}\n\n${opencode}";
        settings = {
          permission.gemini = "allow";
          agent.terra = {
            description = ''
              Cost-efficient general-purpose worker, but not as capable as the primary agent.
              The primary agent reviews its results and takes over if needed.
              Prefer for simpler self-contained delegated tasks
            '';
            model = "openai/gpt-5.6-terra";
            mode = "subagent";
          };
        };

        tools.gemini = ''
          import { realpath } from "node:fs/promises";
          import path from "node:path";

          export default {
            description: "Delegate a self-contained coding task to Gemini.",
            args: {
              prompt: {
                type: "string",
                description: "Task for Gemini to perform",
              },
              directory: {
                type: "string",
                description: "Directory for Gemini to work in",
              },
            },

            async execute(args, context) {
              const directory = await realpath(path.resolve(context.directory, args.directory));
              const contextDir = await realpath(context.directory);

              if (directory !== contextDir) {
                await context.ask({
                  permission: "external_directory",
                  patterns: [`''${directory}/**`],
                  always: [`''${directory}/**`],
                  metadata: { directory },
                });
              }

               const proc = Bun.spawn([
                "podman",
                "run",
                "--rm",
                "--pull",
                "newer",
                "-v",
                "${geminiPrompt}:/root/.gemini/GEMINI.md:ro",
                "--mount",
                "type=volume,src=agy-token,dst=/root/.gemini/antigravity-cli/antigravity-oauth-token,subpath=antigravity-oauth-token",
                "-v",
                `''${directory}:/workspace:rw`,
                "ghcr.io/chickeniq/antigravity-cli",
                "--model",
                "gemini-3.8-flash-medium",
                "--dangerously-skip-permissions",
                "-p",
                args.prompt,
              ], { stdout: "pipe", stderr: "pipe" });

              const [stdout, stderr, exitCode] = await Promise.all([
                new Response(proc.stdout).text(),
                new Response(proc.stderr).text(),
                proc.exited,
              ]);

              if (exitCode !== 0)throw new Error(stderr || `Gemini exited with code ''${exitCode}`);
              return stdout.trim();
            },
          };
        '';
      };
    };
}
