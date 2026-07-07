{ pkgs, ... }: {
  packages.Cable = final.buildApplicationPackage {
    pname = "cable";
    version = "0.10.12";
    src = https://github.com/magillos/Cable/releases/download/0.10.12/Cable-0.10.12-bundled.AppImage;
    sha256 = sha256:81f826e36e38e5ec2e5a1e3a4ae71f32eedeb88f17b06de7f828795b89552c02

    runtimeInputs = with final; [
      zstd  # Provides libzstd.so.1
      python3
      pyqt6  # Or however PyQt6 is provided
    ];

    meta = with final.stdenv.lib; {
      description = "Cable audio routing tool";
      homepage = "https://github.com/magillos/Cable";
      license = licenses.mit;
    };
  };
}
