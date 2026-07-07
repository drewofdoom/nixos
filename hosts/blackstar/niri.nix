{local, username, ...}: {
  home-manager.users.${username}.programs.niri.settings = {
    outputs."DP-1" = {
      mode = [
        { width = 5120.0; }
        { height = 1440.0; }
        { refresh = 120.0; }
      ];
      scale = 1.0;
      position = [
        { x = 0.0; }
        { y = 0.0; }
      ];
    };

    outputs."HDMI-A-1" = {
      mode = [
        { width = 1920.0; }
        { height = 1080.0; }
        { refresh = 60.0; }
      ];
      scale = 1.0;
      position = [
        { x = 1600.0; }
        { y = 1440.0; }
      ];
    };

    layout = {
      gaps = 14;
      preset-column-widths = [
        { proportion = 1.0 / 4.0; }
        { proportion = 1.0 / 2.0; }
        { proportion = 2.0 / 3.0; }
      ];
    };

    input = {
      keyboard.xkb = {
        layout = "us";
      };
      keyboard.track-layout = "window";

      trackball = {
        accel-profile = "adaptive";
        accel-speed = 0.2;
      };

      touch = {
        map-to-output = "HDMI-A-1";
      }
    };
  };
}
