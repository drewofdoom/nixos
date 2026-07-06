{local, ...}: {
  programs.niri.settings = {
    outputs."eDP-1" = {
      scale = local.monitorScale;
    };
  };
};
