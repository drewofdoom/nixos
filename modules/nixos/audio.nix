{pkgs, ...}: {
  # Musnix and latency
  security.rtkit.enable = true;
  musnix = {
    enable = true;
    das_watchdog.enable = true;
    kernel.packages = pkgs.linuxPackages_latest;
  };

  # Pipewire
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.pathsToLink = [ "/share/wireplumber" ];
}
