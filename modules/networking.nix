# Basic Networking configurations
# Services may define additional configurations that will enable them to work properly

{ hostName, ... }: {
  networking = {
    inherit hostName;
    networkmanager.enable = true;

    nftables.enable = true;
  };
}