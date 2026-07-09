# Save this or include it in your ./modules/nixos/ block
{ config, pkgs, ... }: {

  # Declarative configuration via nix-flatpak
  services.flatpak = {
    enable = true;

    # Automatically add the Flathub remote if missing
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # Declare what flatpaks you actually want installed system-wide
    packages = [
    ];

    # Optional but highly recommended cleanup configurations
    update.auto.onCalendar = "weekly"; # Auto update
    uninstallUnmanaged = true;        # Deletes flatpaks installed manually via CLI
  };
}
