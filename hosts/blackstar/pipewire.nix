{ ... }:
  services.pipewire.extraConfig.pipewire."92-low-latency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 64;
      "default.clock.min-quantum" = 64;
      "default.clock.max-quantum" = 64;
    };
  };
}

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
    resample.quality = 1;
  };
};
