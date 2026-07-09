{ config, lib, pkgs, ... }:

let
  # Grab colors directly from your active Stylix palette.
  # base01/base02 are typically the "surface/overlay" background shades in Base16.
  pillBg = "#${config.lib.stylix.colors.base02}";

  # Map standard foreground colors out of your active Stylix theme
  blue    = "#${config.lib.stylix.colors.base0D}";
  cyan    = "#${config.lib.stylix.colors.base0C}";
  magenta = "#${config.lib.stylix.colors.base0E}";
  red     = "#${config.lib.stylix.colors.base08}";
  yellow  = "#${config.lib.stylix.colors.base0A}";
  green   = "#${config.lib.stylix.colors.base0B}";
in
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";

      # Using literal Nix multi-line strings preserves the true \n for the TOML output
      format = ''
$username$directory$git_branch$git_status$fill$c$elixir$elm$golang$haskell$java$julia$nodejs$nim$rust$scala$conda$python$time
[󱞪](${magenta}) '' ;

      # -------------------------------------------------------------------------
      # Modules styled dynamically using your Stylix hex palette strings
      # -------------------------------------------------------------------------

      username = {
        show_always = true;
        format = "[](fg:${pillBg})[$user]($style)[](fg:${pillBg}) ";
        style_user = "bg:${pillBg} fg:${blue} bold";
        style_root = "bg:${pillBg} fg:${red} bold";
      };

      directory = {
        format = "[](fg:${pillBg})[ $path ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${cyan}";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      fill = {
        style = "fg:${pillBg}";
        symbol = " ";
      };

      git_branch = {
        format = "[](fg:${pillBg})[ $symbol$branch ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${magenta}";
        symbol = "󱘎 ";
      };

      git_status = {
        format = "[](fg:${pillBg})[ $all_status$ahead_behind ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${red}";
        conflicted = "=";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${count}⇣\${count}";
        untracked = "?\${count}";
        stashed = "$\${count}";
        modified = "!\${count}";
        staged = "+\${count}";
        renamed = "»\${count}";
        deleted = "-\${count}";
      };

      time = {
        disabled = false;
        format = "[](fg:${pillBg})[ $time ]($style)[](fg:${pillBg})";
        style = "bg:${pillBg} fg:${yellow}";
        time_format = "%R";
      };

      c = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${blue}";
        symbol = " ";
      };

      elixir = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${magenta}";
        symbol = " ";
      };

      elm = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${cyan}";
        symbol = " ";
      };

      golang = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${cyan}";
        symbol = " ";
      };

      haskell = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${magenta}";
        symbol = " ";
      };

      java = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${red}";
        symbol = " ";
      };

      julia = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${magenta}";
        symbol = " ";
      };

      nodejs = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${green}";
        symbol = " ";
      };

      nim = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${yellow}";
        symbol = "󰆥 ";
      };

      rust = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${red}";
        symbol = " ";
      };

      scala = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${red}";
        symbol = " ";
      };

      conda = {
        format = "[](fg:${pillBg})[ $symbol$environment ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${green}";
        symbol = " ";
      };

      python = {
        format = "[](fg:${pillBg})[ $symbol($version) ]($style)[](fg:${pillBg}) ";
        style = "bg:${pillBg} fg:${green}";
        symbol = " ";
      };
    };
  };
}
