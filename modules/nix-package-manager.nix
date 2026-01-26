{
  # Enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nix.settings.trusted-users = [ "kynsonszetau" ];

  # Add Raspberry Pi binary cache
  nix.settings.substituters = [
    "https://nixos-raspberrypi.cachix.org"
  ];
  nix.settings.trusted-public-keys = [
    "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
  ];
}