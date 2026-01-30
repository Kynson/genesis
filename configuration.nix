{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Modules
    ./modules/rpi4.nix
    ./modules/users.nix
    ./modules/nix-package-manager.nix
    ./modules/networking.nix
    ./modules/secrets
    ./modules/home-manager.nix

    # Long running services
    ./services/ssh.nix
    # CoreDNS is put here instead of containerized services is to ensure better performance for local resolution
    # Also it requires binding to low numbered port (53) which requires extra nftables rules to forward it
    ./services/coredns.nix
  ];

  # Set time zone.
  time.timeZone = "Asia/Hong_Kong";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_HK.UTF-8";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11";
}