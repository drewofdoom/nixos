{
  lib,
  pkgs,
  ...
}: {
    programs.fish = {
      enable = true;

      shellAliases = {
        ls = lib.mkForce "lsd";
        ll = lib.mkForce "lsd -l";
        la = lib.mkForce "lsd -la";
        lt = lib.mkForce "lsd --tree";
        cat = "bat";
        top = "btop";
        du = "dust";
        df = "duf";
        ps = "procs";
        ping = "gping";
        vim = "nvim";
        vi = "nvim";
        g = "git";
        lg = "lazygit";
        rebuild = "nh os switch" ;
        update = "nh os boot --update";
      };

      interactiveShellInit = ''
        # Disable the default greeting message
        set fish_greeting
        # Keep Fish inside `nix-shell` instead of falling back to bash.
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish | source
      '';
    };
  }
