{
  lib,
  stdenv,
  fetchFromGitHub,
  replaceVars,
  dbus,
  meson,
  ninja,
  pkg-config,
  wineWow64Packages,
  libxcb,
}:

let
  # Build against wine-staging instead of the yabridge-specific wine build
  wine = wineWow64Packages.staging;

  # Derived from subprojects/asio.wrap
  asio = fetchFromGitHub {
    owner = "chriskohlhoff";
    repo = "asio";
    tag = "asio-1-28-2";
    hash = "sha256-8Sw0LuAqZFw+dxlsTstlwz5oaz3+ZnKBuvSdLW6/DKQ=";
  };

  # Derived from subprojects/bitsery.wrap
  bitsery = fetchFromGitHub {
    owner = "fraillt";
    repo = "bitsery";
    tag = "v5.2.3";
    hash = "sha256-rmfcIYCrANycFuLtibQ5wOPwpMVhpTMpdGsUfpR3YsM=";
  };

  # Derived from subprojects/clap.wrap
  clap = fetchFromGitHub {
    owner = "free-audio";
    repo = "clap";
    tag = "1.1.9";
    hash = "sha256-z2P0U2NkDK1/5oDV35jn/pTXCcspuM1y2RgZyYVVO3w=";
  };

  # Derived from subprojects/function2.wrap
  function2 = fetchFromGitHub {
    owner = "Naios";
    repo = "function2";
    tag = "4.2.3";
    hash = "sha256-+fzntJn1fRifOgJhh5yiv+sWR9pyaeeEi2c1+lqX3X8=";
  };

  # Derived from subprojects/ghc_filesystem.wrap
  ghc_filesystem = fetchFromGitHub {
    owner = "gulrak";
    repo = "filesystem";
    tag = "v1.5.14";
    hash = "sha256-XZ0IxyNIAs2tegktOGQevkLPbWHam/AOFT+M6wAWPFg=";
  };

  # Derived from subprojects/tomlplusplus.wrap
  tomlplusplus = fetchFromGitHub {
    owner = "marzer";
    repo = "tomlplusplus";
    tag = "v3.4.0";
    hash = "sha256-h5tbO0Rv2tZezY58yUbyRVpsfRjY3i+5TPkkxr6La8M=";
  };

  # Derived from vst3.wrap
  vst3 = fetchFromGitHub {
    owner = "robbert-vdh";
    repo = "vst3sdk";
    tag = "v3.7.7_build_19-patched";
    fetchSubmodules = true;
    hash = "sha256-LsPHPoAL21XOKmF1Wl/tvLJGzjaCLjaDAcUtDvXdXSU=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "yabridge";
  # No tagged release on this branch — pin to a commit and use a synthetic
  # version. Update both when you rebase on a newer commit.
  version = "5.1.1-unstable-2026-07-07";

  # NOTE: Also update yabridgectl's cargoHash when this changes
  src = fetchFromGitHub {
    owner = "robbert-vdh";
    repo = "yabridge";
    rev = "ba7022df0aee1e91cde62d7f0e940d3bc43a82b0"; # new-wine10-embedding
    hash = lib.fakeHash; # build once, paste the real hash nix reports
  };

  postUnpack = ''
    (
      cd "$sourceRoot/subprojects"
      cp -R --no-preserve=mode,ownership ${asio} asio
      cp -R --no-preserve=mode,ownership ${bitsery} bitsery
      cp -R --no-preserve=mode,ownership ${clap} clap
      cp -R --no-preserve=mode,ownership ${function2} function2
      cp -R --no-preserve=mode,ownership ${ghc_filesystem} ghc_filesystem
      cp -R --no-preserve=mode,ownership ${tomlplusplus} tomlplusplus
      cp -R --no-preserve=mode,ownership ${vst3} vst3
    )
  '';

  # NOTE: unlike upstream nixpkgs' package, we do NOT carry
  # libyabridge-drop-32-bit-support.patch — new-wine10-embedding branches
  # from a commit that already has that change merged (verified: meson.build
  # has no `with_32bit_libraries` on this branch).
  patches = [
    (replaceVars ./hardcode-dependencies.patch {
      libdbus = dbus.lib;
      inherit wine;
    })
    ./libyabridge-from-nix-profiles.patch
  ];

  postPatch = ''
    patchShebangs .
    (
      cd subprojects
      cp packagefiles/asio/* asio
      cp packagefiles/bitsery/* bitsery
      cp packagefiles/clap/* clap
      cp packagefiles/function2/* function2
      cp packagefiles/ghc_filesystem/* ghc_filesystem
    )
  '';

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    wine
  ];

  buildInputs = [
    libxcb
    dbus
  ];

  mesonFlags = [
    "--cross-file"
    "cross-wine.conf"
    "-Dbitbridge=false"
    "-Dtomlplusplus:generate_cmake_config=false"
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin" "$out/lib"
    cp yabridge-host.exe{,.so} "$out/bin"
    cp libyabridge{,-chainloader}-{vst2,vst3,clap}.so "$out/lib"
    runHook postInstall
  '';

  postFixup = ''
    for exe in "$out"/bin/*.exe; do
      substituteInPlace "$exe" \
        --replace-fail 'WINELOADER="wine"' 'WINELOADER="${wine}/bin/wine"'
    done
  '';

  meta = {
    description = "yabridge (new-wine10-embedding branch), built against wine-staging";
    homepage = "https://github.com/robbert-vdh/yabridge/tree/new-wine10-embedding";
    license = lib.licenses.gpl3Plus;
    platforms = [ "x86_64-linux" ];
  };
})
