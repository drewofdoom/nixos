{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    docker.storageDriver = "btrfs";
  };
}
