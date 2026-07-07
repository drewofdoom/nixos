{pkgs, ...}: {
  # Polkit + a keyring so apps can request privileges and store secrets.
  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;

  # Hardware-accelerated graphics (needed by niri / OpenGL apps).
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Bluetooth + a few desktop conveniences.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  services.upower.enable = true;
  programs.gnome-disks.enable = true;
  services.gvfs.enable = true; # trash + mounting for file managers.
  services.envfs.enable = true;
  programs.nix-ld.enable = true;
  programs.xwayland.enable = true;

  # A handful of GUI essentials live at the system level so they're always
  # present regardless of which user logs in.
  environment.systemPackages = with pkgs; [
    brightnessctl
    playerctl
    wl-clipboard
    grim
    slurp
    libnotify
    xdg-utils
    xwayland-satellite
    wineWow64Packages.staging
    yabridge
    yabridgectl
    winetricks
    glib
  ];

  services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
    };
}
