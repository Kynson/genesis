{ config, ... }: {
  sops = {
    defaultSopsFile = ./secrets.json; 
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets.sshPublicKey.owner = config.users.users.kynsonszetau.name;
    secrets.sshPublicKey.group = config.users.users.kynsonszetau.group;
    # Read only by kynsonszetau
    secrets.sshPublicKey.mode = "0400";
  };
}