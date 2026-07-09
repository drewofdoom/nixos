{local, config, username, ...}: {
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

    includes = with config.lib.niri.include; [
      {path = "/home/${username}/.config/niri/dms/alttab.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/binds.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/colors.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/cursor.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/layout.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/outputs.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/windowrules.kdl"; optional = true;}
      {path = "/home/${username}/.config/niri/dms/wpblur.kdl"; optional = true;}
    ];
  };
}
