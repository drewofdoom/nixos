{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  # GUI desktop apps. Browsers and file managers live here rather than in the
  # CLI bundle.
  home.packages = [
    # Desktop
    pkgs.nautilus
    pkgs.proton-pass
    pkgs.proton-vpn
    pkgs.telegram-desktop
    pkgs.slack

    # DAWs
    pkgs.reaper
    pkgs.reaper-sws-extension
    pkgs.reaper-reapack-extension

    # Plugins
    pkgs.boops
    pkgs.chow-tape-model
    pkgs.distrho-ports
    pkgs.drumgizmo
    pkgs.infamousplugins
    pkgs.lsp-plugins
    pkgs.moospace
    pkgs.openav-artyfx
    pkgs.plujain-ramp
    pkgs.resonarium
    pkgs.surge-xt
    pkgs.tunefish
    pkgs.vital
    pkgs.x42-avldrums
    pkgs.x42-gmsynth
    pkgs.x42-plugins
    pkgs.zlcompressor
    pkgs.zlequalizer
    pkgs.zlsplitter
  ];

  # Zen browser — Firefox-based, from the community flake (beta channel).
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  stylix.targets.zen-browser.profileNames = ["default"];
}
