# Basic Networking configurations
# Services may define additional configurations that will enable them to work properly

{ lib, hostName, ... }: 
let
  portForwardTableName = "port_forward";

  portForwardConfigurations = [
    {
      protocol = "tcp";
      source = "80";
      target = "8080";
    }
  ];

  # References:
  # https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/getting-started-with-nftables_configuring-and-managing-networking
  # https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/7/html/security_guide/sec-configuring_port_forwarding_using_nftables
  portForwardRules = lib.map
  ({ protocol, source, target }:
    "${protocol} dport ${source} meta mark set 1 redirect to :${target} comment \"Forward port ${source} to port ${target}\""
  )
  portForwardConfigurations;
  # The forwarded packets will further be processed by `nixos-fw` table (networking.firewall), so we need to allow them there as well
  # The mark ensure only packets forwarded by rules in `port_forward` table are accepted
  portForwardAllowRules = lib.map
  ({ protocol, target, ...}:
    "${protocol} dport ${target} meta mark 1 accept comment \"Allow forwarded packet to port ${target}\""
  )
  portForwardConfigurations;
in
{
  networking = {
    inherit hostName;
    networkmanager.enable = true;

    nftables.enable = true;

    # Enable forwarding for containers (can't be done inside home manager configuration)
    nftables.tables.${portForwardTableName} = {
      family = "inet";
      content = ''
        chain prerouting {
          type nat hook prerouting priority dstnat;
          policy accept;

          ${lib.concatStringsSep "\n" portForwardRules}
        }
      '';
    };

    firewall.extraInputRules = lib.concatStringsSep "\n" portForwardAllowRules;
  };
}