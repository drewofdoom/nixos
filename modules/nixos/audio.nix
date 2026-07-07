{pkgs, ...}: {
  # PipeWire is the modern audio stack; disable PulseAudio in favour of it.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  musnix = {
    enable = true;
    das_watchdog.enable = true;
    kernel.packages = pkgs.linuxPackages_latest;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    # DAWs
    reaper
    reaper-sws-extension
    reaper-reapack-extension

    # Plugins
    boops
    chow-tape-model
    distrho-ports
    drumgizmo
    infamousplugins
    lsp-plugins
    moospace
    openav-artyfx
    plujain-ramp
    resonarium
    surge-xt
    tunefish
    vital
    x42-avldrums
    x42-gmsynth
    x42-plugins
    zlcompressor
    zlequalizer
    zlsplitter
  ];
}
