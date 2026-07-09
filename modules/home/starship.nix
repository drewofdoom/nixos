{...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = {
      add_newline = true;
      command_timeout = 1000;
    };
  };
}
