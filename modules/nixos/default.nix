{...}: {
  imports = [
    ./boot.nix
    ./networking.nix
    ./audio.nix
    ./flatpak.nix
    ./hardware.nix
    ./fonts.nix
    ./niri.nix
    ./noctalia.nix
    ./desktop.nix
    ./stylix.nix
    ./steam.nix
    ./tailscale.nix
    ./users.nix
  ];

  # Flakes + the modern nix CLI.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.auto-optimise-store = true;

  nix.settings.trusted-users = [ "@wheel" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # A lean system-wide package set; everything user-facing lives in home-manager.
  environment.systemPackages = [];
}
