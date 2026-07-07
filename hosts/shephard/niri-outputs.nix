{local, username, ...}: {
  home-manager.users.${username}.programs.niri.settings = {
    outputs."eDP-1" = {
      scale = local.monitorScale;
    };
  };
}
