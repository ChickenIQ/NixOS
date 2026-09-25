{
  flake.homeModules.helium =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.self.helium ];

      xdg = {
        mimeApps.defaultApplications = {
          "x-scheme-handler/https" = "helium.desktop";
          "x-scheme-handler/http" = "helium.desktop";
          "application/xhtml+xml" = "helium.desktop";
          "text/html" = "helium.desktop";
        };

        desktopEntries.chatgpt = {
          exec = ''helium --app="https://chatgpt.com/?temporary-chat=true"'';
          name = "ChatGPT";
          icon = "helium";
        };
      };
    };
}
