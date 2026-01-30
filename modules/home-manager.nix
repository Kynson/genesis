{ adminUserName, workerUserName, workerHomeDirectory, ... }: {
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # pkgs is available by default according to the docs
  home-manager.users.${adminUserName} = ../home/admin.nix;
  home-manager.users.${workerUserName} = ../home/worker.nix;

  home-manager.extraSpecialArgs = { inherit adminUserName workerUserName workerHomeDirectory; };
}