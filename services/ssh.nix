let 
  #allowedManagementIPs = [ "192.168.1.185" ];
in {
  services.openssh = {
    enable = true;
    # We have custom rules below
    #openFirewall = false;
  };

  #networking.firewall.extraInputRules = ''
  #    ip saddr { ${builtins.concatStringsSep ", " allowedManagementIPs} } tcp dport 22 accept comment "Allow SSH from management IPs"
  #  '';
}