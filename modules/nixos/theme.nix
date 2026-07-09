{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Engines
    adw-gtk3
    # qt6ct
    # Cursors
    rose-pine-cursor

    # Fonts
    maple-mono.NF
    nerd-fonts.fira-code
    fira-sans
    noto-fonts
    noto-fonts-color-emoji
  ];
}
