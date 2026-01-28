{ pkgs, adminUserName, ... }: {
  imports = [ ./base.nix ];

  home.username = adminUserName;
  home.homeDirectory = "/home/${adminUserName}";

  home.packages = with pkgs; [
    google-authenticator  
  ];
}