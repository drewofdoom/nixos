{ config, pkgs, ... }: {

    remotes = [{
      name = "flathub";
      location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    }];

    packages = [
      "de.haeckerfelix.Fragments"
    ];

    # Cleans up flatpaks not declared here
    uninstallUnmanaged = true;
  };
}
