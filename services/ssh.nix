let 
  #allowedManagementIPs = [ "192.168.1.185" ];
in 
{ pkgs, adminUserName, ... }: {
  services.openssh = {
    enable = true;
    # We have custom rules below
    #openFirewall = false;
  };

  services.openssh.settings = {
    PermitRootLogin = "no";
    PasswordAuthentication = false;
    # Force public key then keyboard-interactive (for google authenticator)
    AuthenticationMethods = builtins.concatStringsSep "," [ "publickey" "keyboard-interactive" ];
    AllowUsers = [ adminUserName ];
  };

  # Warning: This override other PAM settings for sshd, for example security.pam.loginLimits
  # Handle this with care! Misconfiguration may lock access to the system or allow unauthenticated access.
  # The below is generated a NixOS system with google authenticator disabled

  # Reference: https://github.com/NixOS/nixpkgs/issues/115044
  # Use security.pam.services.sshd.googleAuthenticator (or new option, if direct SSH option is added) if the above is fixed
  security.pam.services.sshd.text = ''
    # Account management.
    account required ${pkgs.linux-pam}/lib/security/pam_unix.so # unix (order 10900)

    # Authentication management.
    # "no_increment_hotp": make sure the counter isn't incremented for failed attempts.
    auth required ${pkgs.google-authenticator}/lib/security/pam_google_authenticator.so no_increment_hotp # google_authenticator (order 12500)

    # Password management.
    password sufficient ${pkgs.linux-pam}/lib/security/pam_unix.so nullok yescrypt # unix (order 10200)

    # Session management.
    session required ${pkgs.linux-pam}/lib/security/pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
    session required ${pkgs.linux-pam}/lib/security/pam_unix.so # unix (order 10200)
    session required ${pkgs.linux-pam}/lib/security/pam_loginuid.so # loginuid (order 10300)
    session optional ${pkgs.systemd}/lib/security/pam_systemd.so # systemd (order 12100)
  '';

  #networking.firewall.extraInputRules = ''
  #    ip saddr { ${builtins.concatStringsSep ", " allowedManagementIPs} } tcp dport 22 accept comment "Allow SSH from management IPs"
  #  '';
}