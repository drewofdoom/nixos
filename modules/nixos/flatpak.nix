# Save this or include it in your ./modules/nixos/ block
{ config, pkgs, ... }: {

  # Ensure the flatpak service is enabled globally
  services.flatpak.enable = true;

  # Declarative configuration via nix-flatpak
  services.flatpak = {
    # Automatically add the Flathub remote if missing
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # Declare what flatpaks you actually want installed system-wide
    packages = [
      # "org.signal.Signal"
      # "com.valvesoftware.Steam"
      # You can specify exact remotes if you use multiples
      # { appId = "org.gimp.GIMP"; origin = "flathub"; }
    ];

    # Optional but highly recommended cleanup configurations
    update.auto.onCalendar = "weekly"; # Auto update
    uninstallUnmanaged = true;        # Deletes flatpaks installed manually via CLI
  };
}
