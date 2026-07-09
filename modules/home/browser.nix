{ ... }:
{
  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    "default-web-browser" = [ "brave.desktop" ];
    "text/html" = [ "brave.desktop" ];
    "x-scheme-handler/http" = [ "brave.desktop" ];
    "x-scheme-handler/https" = [ "brave.desktop" ];
  };
}
