{ ... }:
{
  # 10-disable-hfp.conf equivalent
  services.pipewire.extraConfig.pipewire."10-disable-hfp" = {
    "context.modules" = [
      {
        name = "libpipewire-module-bluetooth-policy";
        args = {
          auto_switch_profile = false;
        };
        flags = [ "ifexists" ];
      }
    ];
  };

  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 64;
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 64;
    };
  };

  services.pipewire.extraConfig.pipewire."93-vban-receiver" = {
    "context.modules" = [
      {
        name = "libpipewire-module-vban-recv";
        args = {
          "local.ifname" = "enp7s0";
          "sess.latency.msec" = 12;
          "node.always-process" = true;
          "node.driver" = false;
          "audio.position" = [ "FL" "FR" ];
          "resample.quality" = 0;
          "resample.disable" = false;

          "stream.props" = {
            "media.class" = "Audio/Source";
            "node.name" = "vban-receiver";
            "priority.session" = 100;
            "audio.format" = "S24_3LE";
          };

          "stream.rules" = [
            {
              matches = [ { "sess.name" = "~.*"; } ];
              actions = {
                "create-stream" = {
                  "stream.props" = {
                    "audio.position" = [ "FL" "FR" ];
                    "media.class" = "Audio/Source";
                    "node.name" = "vban-receiver";
                    "priority.session" = 100;
                    "audio.format" = "S24_3LE";
                  };
                };
              };
            }
          ];
        };
      }
    ];
  };

  services.pipewire.extraConfig.pipewire-pulse."92-low-latency" = {
    context.modules = [
      {
        name = "libpipewire-module-protocol-pulse";
        args = {
          pulse.min.req = "64/48000";
          pulse.default.req = "64/48000";
          pulse.max.req = "64/48000";
          pulse.min.quantum = "64/48000";
          pulse.max.quantum = "64/48000";
        };
      }
    ];
    stream.properties = {
      node.latency = "64/48000";
      resample.quality = 4;
    };
  };
}
