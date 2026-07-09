{local, ...}: {
  programs.niri.settings = {
    prefer-no-csd = true;

    hotkey-overlay.skip-at-startup = true;

    layout = {
      gaps = 14;
      focus-ring = {
        enable = true;
      };
      border = {
        enable = false;
        # width = 4;
      };
      always-center-single-column = true;
    };
  };
}
