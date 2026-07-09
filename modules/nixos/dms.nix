{ pkgs, username, ... }:
{
  programs.dms-shell.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };
}
