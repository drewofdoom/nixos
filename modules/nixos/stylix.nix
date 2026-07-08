{pkgs, ...}: {
  # One palette to rule them all. Stylix derives colors for niri, noctalia,
  # ghostty, bat, btop, neovim, GTK/Qt and more from a single base16 scheme.
  stylix = {
    enable = true;
    autoEnable = true;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    # A hint of terminal transparency for that layered desktop look.
    opacity.terminal = 0.85;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Classic-Cursor";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.maple-mono.NF;
        name = "Maple Mono NF";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        terminal = 12;
        applications = 11;
        desktop = 11;
        popups = 11;
      };
    };
  };
}
