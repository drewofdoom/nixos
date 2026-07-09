{username, ...}: {
  imports = [
    ./cli.nix
    ./zsh.nix
    ./fish.nix
    ./starship.nix
    ./git.nix
    ./ghostty.nix
    ./neovim.nix
    ./zed.nix
    ./gtk.nix
    ./niri.nix
    ./noctalia.nix
    ./direnv.nix
    ./apps.nix
    ./flatpak.nix
    ./media.nix
    ./discord.nix
    ./browser.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.pointerCursor.enable = true;

  # Match system.stateVersion in hosts/nnn/default.nix. Don't bump casually.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
