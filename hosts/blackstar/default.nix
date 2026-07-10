{config, local, pkgs, username,...}: {
  imports = [
    ./hardware-configuration.nix
    ./niri.nix
    ./pipewire.nix
  ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    powerManagement.kernelSuspendNotifier = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  hardware.nvidia-container-toolkit = {
    enable = true;
  };

  services.lact.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = local.hostName;

  # ⇩ Timezone comes from local.nix; locale/keyboard layout below.
  time.timeZone = local.timeZone;
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  console.keyMap = "us";

  # Docker
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon.settings = {
      storage-driver = "btrfs";
    };
  };
  users.extraGroups.docker.members = [
    "@wheel"
    username
  ];

  # The release this config was written against. Do NOT bump casually after
  # first install — read the NixOS release notes first.
  system.stateVersion = "26.05";
}
