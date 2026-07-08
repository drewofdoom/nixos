{ config, pkgs, ... }: {

  services.flatpak = {
    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];

    packages = [
      "de.haeckerfelix.Fragments"
      "io.github.flattool.Warehouse"
      "com.github.tchx84.Flatseal"
      rec {
        appId = "com.github.magillos.cable";
        sha256 = "sha256:fb754c5f9dd296d650bdaf9a9915f627e5748205944a22ed1586c516b56af549";
        bundle = "${pkgs.fetchurl {
          url = "https://github.com/magillos/Cable/releases/download/0.10.12/Cable-0.10.12.flatpak";
          inherit sha256;
        }}";
      }
    ];

    # Cleans up flatpaks not declared here
    uninstallUnmanaged = true;
  };
}
