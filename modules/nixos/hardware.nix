{pkgs, ...}: {
  # Firmware updates via LVFS: `fwupdmgr refresh && fwupdmgr update` pulls
  # BIOS/EC/Thunderbolt updates. ThinkPads are well supported upstream.
  services.fwupd.enable = true;

  # Compressed RAM swap. Faster than the disk swap partition and saves NVMe
  # wear; with 32 GB RAM the default (50% of RAM) is plenty of headroom.
  # (Note: too small to hibernate 32 GB — that still needs a disk swap ≥ RAM.)
  zramSwap.enable = true;
}
