{
  lib,
  rustPlatform,
  yabridge,
  makeWrapper,
  wineWow64Packages,
}:

rustPlatform.buildRustPackage {
  pname = "yabridgectl";
  version = yabridge.version;

  src = yabridge.src;
  sourceRoot = "${yabridge.src.name}/tools/yabridgectl";

  # Build once with fakeHash, paste in the value nix reports
  cargoHash = lib.fakeHash;

  patches = [
    ./chainloader-from-nix-profiles.patch
    ./remove-dependency-verification.patch
  ];

  patchFlags = [ "-p3" ];

  nativeBuildInputs = [ makeWrapper ];

  postFixup = ''
    wrapProgram "$out/bin/yabridgectl" \
      --prefix PATH : ${
        lib.makeBinPath [
          wineWow64Packages.staging # winedump
        ]
      }
  '';

  meta = {
    description = "yabridgectl (new-wine10-embedding branch), built against wine-staging";
    homepage = yabridge.meta.homepage;
    license = lib.licenses.gpl3Plus;
    platforms = yabridge.meta.platforms;
    mainProgram = "yabridgectl";
  };
}
