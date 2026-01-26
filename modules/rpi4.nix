# Raspberry Pi 4 specific configuration
# References:
# https://nixos.wiki/wiki/NixOS_on_ARM#NixOS_installation_.26_configuration
# https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi
# Most should be handled by nixos-raspberrypi module

{ nixos-raspberrypi, ... }: {
  imports = with nixos-raspberrypi.nixosModules; [
    # Hardware configuration
    raspberry-pi-4.base
    raspberry-pi-4.bluetooth
    raspberry-pi-4.display-vc4
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  services.udev.extraRules = ''
    # Ignore partitions with "Required Partition" GPT partition attribute
    # On our RPis this is firmware (/boot/firmware) partition
    ENV{ID_PART_ENTRY_SCHEME}=="gpt", \
      ENV{ID_PART_ENTRY_FLAGS}=="0x1", \
      ENV{UDISKS_IGNORE}="1"
  '';
}