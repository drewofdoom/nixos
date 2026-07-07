{local, ...}: {
  programs.niri.settings = {

    prefer-no-csd = true;

    input = {
      keyboard.xkb = {
        layout = "us,ru";
        options = "grp:alt_shift_toggle"; # Alt+Shift switches US <-> Russian
      };
      # Each window remembers its own layout ("global" = one shared layout).
      keyboard.track-layout = "window";
      touchpad = {
        tap = true;
        natural-scroll = true;
        dwt = true; # disable-while-typing
      };
      mouse = {
        accel-profile = "flat";
        natural-scroll = true; # match macOS-style scrolling (also set on touchpad)
      };
      focus-follows-mouse.enable = true;
    };

    overview = {
      workspace-shadow.enable = false;
    };

    hotkey-overlay.skip-at-startup = true;

    layout = {
      focus-ring = {
        enable = false;
      };
      border.enable = true;
      background-color = "transparent";
    };

    window-rules = [
      {
        clip-to-geometry = true;
        geometry-corner-radius = {
          bottom-left = 20.0;
          bottom-right = 20.0;
          top-left = 20.0;
          top-right = 20.0;
        };
      }
      {
        matches = [
          { app-id = "dev.noctalia.Noctalia"; }
        ];
        open-floating = true;
        default-column-width = { fixed = 1080; };
        default-window-height = { fixed = 920; };
      }
    ];

    layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-wallpaper"; }
        ];
        place-within-backdrop = true;
      }
    ];

    # Subtle, fast animations — omarchy-style polish without distraction.
    # animations.slowdown = 0.7;

    # niri-flake's canonical attribute form: `action.<name> = <args>`. No-arg
    # actions take `{ }`; spawn takes a string or a list of argv strings.
    binds = {
      # Launchers
      "Mod+Escape".action.toggle-overview = {};
      "Mod+T".action.spawn = "ghostty";
      # Noctalia v5 IPC: `noctalia msg <command>` (the old `ipc call` form and
      # the `noctalia-shell` binary are gone). The launcher is a named panel.
      "Mod+Space".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "Mod+S".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "control-center"
      ];
      "Mod+Comma".action.spawn = [
        "noctalia"
        "msg"
        "settings-toggle"
      ];
      "Mod+B".action.spawn = "zen-beta"; # browser
      "Mod+E".action.spawn = "nautilus"; # file manager

      # Window management
      "Mod+Q".action.close-window = {};
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+W".action.toggle-column-tabbed-display = {};
      "Mod+V".action.toggle-window-floating = {};

      # Focus
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Up".action.focus-window-down = {};
      "Mod+Down".action.focus-window-up = {};

      # Move
      "Mod+Shift+Left".action.move-column-left = {};
      "Mod+Shift+Right".action.move-column-right = {};
      "Mod+Shift+Down".action.move-window-down = {};
      "Mod+Shift+Up".action.move-window-up = {};

      # Sizing
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;
      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;

      # Screenshots
      "Print".action.screenshot = {};
      "Mod+Print".action.screenshot-window = {};
      "Ctrl+Print".action.screenshot-screen = {};

      # Help + session
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};
      "Mod+Shift+E".action.quit = {};

      # Media / brightness keys
      "XF86AudioRaiseVolume".action.spawn = ["noctalia" "msg" "volume-up"];
      "XF86AudioLowerVolume".action.spawn = ["noctalia" "msg" "volume-down"];
      "XF86AudioMute".action.spawn = ["noctalia" "msg" "volume-mute"];
      "XF86AudioPlay".action.spawn = ["noctalia" "msg" "media" "toggle"];
      "XF86AudioNext".action.spawn = ["noctalia" "msg" "media" "next"];
      "XF86AudioPrev".action.spawn = ["noctalia" "msg" "media" "previous"];
      "XF86MonBrightnessUp".action.spawn = ["noctalia" "msg" "brightness-up"];
      "XF86MonBrightnessDown".action.spawn = ["noctalia" "msg" "brightness-down"];
    };
  };
}
