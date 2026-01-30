{ workerUserName, workerHomeDirectory, ... }: {
  imports = [ ./base.nix ];

  home.username = workerUserName;
  home.homeDirectory = workerHomeDirectory;
}