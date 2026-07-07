{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  # GUI desktop apps. Browsers and file managers live here rather than in the
  # CLI bundle.
  home.packages = with pkgs; [
    # Desktop
    nautilus
    proton-pass
    proton-vpn
    telegram-desktop
    slack
    sone
    sushi
    crosspipe
    plex-desktop

    # DAWs
    reaper

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

  # Zen browser — Firefox-based, from the community flake (beta channel).
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  stylix.targets.zen-browser.profileNames = ["default"];
}
