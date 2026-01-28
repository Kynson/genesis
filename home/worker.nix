{ workerUserName, ... }: {
  imports = [ ./base.nix ];

  home.username = workerUserName;
  home.homeDirectory = "/home/${workerUserName}";
}