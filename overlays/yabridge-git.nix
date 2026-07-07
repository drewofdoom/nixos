final: prev: {
  yabridge = final.callPackage ../pkgs/yabridge-git/package.nix { };
  yabridgectl = final.callPackage ../pkgs/yabridgectl-git/package.nix { };
}
