{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    wineWow64Packages.staging
    yabridge
    yabridgectl
  ];
}
