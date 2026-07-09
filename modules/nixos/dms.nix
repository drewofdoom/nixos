{ inputs, pkgs, username, ... }:
{
  imports = [ inputs.dms.nixosModules.dank-material-shell ];

  programs.dank-material-shell = {
    enable = true;

    enableSystemMonitoring = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    enableVPN = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dms-shell changes
    };
  };

  programs.dsearch = {
    enable = true;
    systemd = {
      enable = true;               # Enable systemd user service
      target = "graphical-session.target";   # Start with user session
    };
  };

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${username}";
  };

  systemd.user.services.niri-flake-polkit.enable = false;
}
