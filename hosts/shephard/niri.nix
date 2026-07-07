{local, username, ...}: {
  home-manager.users.${username}.programs.niri.settings = {
    outputs."eDP-1" = {
      scale = 1.0;
    };

    layout = {
      gaps = 14;
      center-focused-column = "always";
      preset-column-widths = [
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      default-column-width.proportion = 2.0 / 2.0;
    };
  };
}
