{
  flake.nixosModules.display-manager =
    {
      config,
      pkgs,
      ...
    }:
    {
      services.greetd = {
        enable = true;
        useTextGreeter = true;
        settings.default_session.command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
            --time --remember --asterisks --remember-session \
            --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
        '';
      };
    };
}
