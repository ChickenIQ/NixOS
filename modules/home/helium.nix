{
  flake.homeModules.helium =
    { pkgs, ... }:
    {
      xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/https" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "application/xhtml+xml" = "helium.desktop";
        "text/html" = "helium.desktop";
      };

      home.packages = [ pkgs.self.helium ];
    };
}
