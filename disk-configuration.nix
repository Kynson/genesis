{
  disko.devices.disk.main = {
    type = "disk";
    # USB SSD Drive
    device = "/dev/sda";
    content = {
      type = "gpt";
      partitions = {
        FIRMWARE = {
          # Required for the firmware to be found first
          priority = 1;
          label = "FIRMWARE";
          size = "1024M";
          type = "0700";
          attributes = [
            0 # Required Partition
          ];
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot/firmware";
            mountOptions = [
              # Disable access time updates
              "noatime"
              # Skip auto mount
              "noauto"
              "x-systemd.automount"
              # Unmount after idle
              "x-systemd.idle-timeout=1min"
            ];
          };
        };
        ESP = {
          label = "ESP";
          size = "1024M";
          type = "EF00";
          attributes = [
            2 # Legacy BIOS Bootable, for U-Boot to find extlinux config
          ];
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = [
              "noatime"
              "noauto"
              "x-systemd.automount"
              "x-systemd.idle-timeout=1min"
              # Only allow root access
              "umask=0077"
            ];
          };
        };
        root = {
          # Linux ARM64 root (/)
          type = "8305";
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = [ "-f" ];
            subvolumes = {
              "/root" = {
                mountpoint = "/";
              };
              "/nix" = {
                mountpoint = "/nix";
                mountOptions = [ "noatime" ];
              };
              "/swap" = {
                mountpoint = "/.swapvol";
                swap.swapfile.size = "8G";
              };
            };
          };
        };
      };
    };
  };
}