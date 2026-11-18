{
  flake.homeModules.luciole =
    { inputs, ... }:
    {
      imports = [ inputs.luciole.homeModules.default ];

      programs.luciole = {
        enable = true;

        settings.browser = {
          always_show_status_bar = true;
          always_show_tab_bar = false;
          sort_descending = false;
          typing_mode = "filter";
          grid_icon_size = 64;
          sidebar_width = 190;
          show_network = false;
          show_preview = false;
          show_hidden = true;
          view_mode = "grid";
          sort_by = "type";
        };
      };
    };
}
