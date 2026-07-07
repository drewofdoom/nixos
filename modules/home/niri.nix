{local, ...}: {
  programs.niri.settings = {

    prefer-no-csd = true;

    overview = {
      workspace-shadow.enable = false;
    };

    hotkey-overlay.skip-at-startup = true;

    spawn-at-startup = [
      { sh = "/run/current-system/sw/libexec/polkit-gnome-authentication-agent-1"; }
    ];

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
        background-effect = {
          blur = true;
          xray = false;
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
      {
        matches = [
          { app-id="^com.mitchellh.ghostty$"; }
        ];
        default-column-width = { fixed = 1200; };
      }
      {
        matches = [
          { app-id = "^org.telegram.desktop$"; }
        ];
        default-column-width = { fixed = 600; };
      }
      {
        matches = [
          { app-id = "^org.gnome.DejaDup$"; }
        ];
        default-column-width = { fixed = 850; };
      }
      {
        matches = [
          { app-id = "^zen-beta$"; }
          { title = "Pictune-in-Picture"; }
        ];
        default-column-width = { fixed = 850; };
      }
      {
        matches = [
          { app-id = "^steam_app_.*"; }
        ];
        open-fullscreen = true;
      }
    ];

    layer-rules = [
      {
        matches = [
          { namespace = "^noctalia-backdrop"; }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          { namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$"; }
        ];
        background-effect = {
          xray = false;
        };
      }
    ];

    animations.slowdown = 0.7;

    # niri-flake's canonical attribute form: `action.<name> = <args>`. No-arg
    # actions take `{ }`; spawn takes a string or a list of argv strings.
    binds = {
      # Launchers
      "Mod+Escape" = {
        action.toggle-overview = {};
        repeat = false;
      };
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
      "Mod+Q" = {
        action.close-window = {};
        repeat = false;
      };
      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};
      "Mod+W".action.toggle-column-tabbed-display = {};
      "Mod+V".action.toggle-window-floating = {};
      "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = {};

      # Focus
      "Mod+C".action.center-column = {};
      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Down".action.focus-window-down = {};
      "Mod+Shift+Left".action.focus-monitor-left = {};
      "Mod+Shift+Right".action.focus-monitor-right = {};
      "Mod+Shift+Down".action.focus-monitor-down = {};
      "Mod+Shift+Up".action.focus-monitor-up = {};
      "Mod+Page_Down".action.focus-workspace-down = {};
      "Mod+Page_Up".action.focus-workspace-up = {};
      "Mod+WheelScrollLeft".action.focus-column-left = {};
      "Mod+WheelScrollRight".action.focus-column-right = {};
      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = {};
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = {};
        cooldown-ms = 150;
      };

      # Move
      "Mod+Ctrl+Left".action.move-column-left = {};
      "Mod+Ctrl+Right".action.move-column-right = {};
      "Mod+Ctrl+Down".action.move-window-down = {};
      "Mod+Ctrl+Up".action.move-window-up = {};
      "Mod+Shift+Ctrl+Left".action.move-column-to-monitor-left = {};
      "Mod+Shift+Ctrl+Down".action.move-column-to-monitor-down = {};
      "Mod+Shift+Ctrl+Up".action.move-column-to-monitor-up = {};
      "Mod+Shift+Ctrl+Right".action.move-column-to-monitor-right = {};
      "Mod+Shift+Page_Down".action.move-workspace-down = {};
      "Mod+Shift+Page_Up".action.move-workspace-up = {};
      "Mod+Ctrl+WheelScrollDown" = {
        action.move-column-to-workspace-down = {};
        cooldown-ms = 150;
      };
      "Mod+Ctrl+WheelScrollUp" = {
        action.move-column-to-workspace-up = {};
        cooldown-ms = 150;
      };

      # Consume
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};

      # Sizing
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+Shift+R".action.switch-preset-column-width-back = {};
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
      "Ctrl+Print".action.screenshot-window = {};
      "Alt+Print".action.screenshot-screen = {};

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

      # Power off monitors
      "Mod+Shift+P".action.power-off-monitors = {};
    };
  };
}
