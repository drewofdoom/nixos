{...}: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      window-padding-x = 12;
      window-padding-y = 12;
      window-decoration = false;
      cursor-style = "bar";
      cursor-style-blink = true;
      mouse-hide-while-typing = true;
      copy-on-select = "clipboard";
      confirm-close-surface = false;
      window-inherit-working-directory = true;
    };
  };
}
