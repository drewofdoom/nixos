{local, username, ...}: {
  home-manager.users.${username}.programs.niri.settings = {
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
      };
    };

    outputs."DP-1" = {
      mode = {
        width = 5120;
        height = 1440;
        refresh = 120.0;
      };
      scale = 1.0;
      position = {
        x = 0;
        y = 0;
      };
      layout = {
        preset-column-widths = [
          { proportion = 1.0 / 4.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];
      };
    };

    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 60.0;
      };
      scale = 1.0;
      position = {
        x = 1600;
        y = 1440;
      };
      layout = {
        preset-column-widths = [
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];
        default-column-width = { proportion = 1.0; };
      };
    };

    window-rules = [
      {
        matches = [
          { title = "^Picture-in-Picture$"; }
          { title = "^Picture in picture$"; }
        ];
        open-floating = true;
      }
      {
        matches = [
          { app-id = "^zen-beta$"; }
          { app-id = "^brave-browser$"; }
        ];
        default-column-width = { proportion = 1.0 / 3.0; };
      }
    ];
  };
}
