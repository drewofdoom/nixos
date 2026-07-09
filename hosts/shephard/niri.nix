{local, username, ...}: {
  home-manager.users.${username}.programs.niri.settings = {
    outputs."eDP-1" = {
      scale = 1.0;
    };

    layout = {
      preset-column-widths = [
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];
      default-column-width = { proportion = 1.0; };
    };

    input = {
      keyboard.xkb = {
        layout = "us";
      };
      keyboard.track-layout = "window";

      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true; # disable-while-typing
      };
    };
  };
}
