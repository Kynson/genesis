{ workerUserName, workerHomeDirectory,... }: {
  imports = [ 
    ../base.nix 
    ./containers 
  ];

  home.username = workerUserName;
  home.homeDirectory = workerHomeDirectory;
}