{local, username, ...}: {
  home-manager.users.${username}.programs.cava.settings = {
    general.framerate = 60;
    live-config = 1;
    blend_direction = "up";
    smoothing = {
      noise_reduction = 25;
      monstercat = 0;
    };
  };
}
