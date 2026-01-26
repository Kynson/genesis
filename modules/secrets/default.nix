{
  sops = {
    defaultSopsFile = ./secrets.json; 
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.kynsonszetauHashedPassword.neededForUsers = true;
  };
}