{
  description = "Genesis server configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixos-raspberrypi, disko, sops-nix, nixpkgs, home-manager, ... }@inputs: 
    let 
      system = "aarch64-linux";
      devSystem = "aarch64-darwin";
      hostName = "genesis";
      adminUserName = "kynsonszetau";

      workerUserName = "genesis";
      workerUid = 900;
      workerHomeDirectory = "/var/lib/${workerUserName}";

      devPkgs = import nixpkgs {
        system = devSystem;
      };
    in {
      nixosConfigurations.${hostName} = nixos-raspberrypi.lib.nixosSystem {
        inherit system;
        # Pass all inputs to the modules below for easy access.
        specialArgs = inputs // { 
          inherit hostName adminUserName workerUserName workerUid workerHomeDirectory;
        };
        modules = [
          ./configuration.nix

          sops-nix.nixosModules.sops

          home-manager.nixosModules.home-manager

          disko.nixosModules.disko
          ./disk-configuration.nix
        ];
      };

      devShells.${devSystem}.default = devPkgs.mkShell {
        packages = with devPkgs; [
          sops
        ];

        shellHook = ''
          export SOPS_AGE_KEY_FILE=./sops-keys.txt
        '';
      };
    };
}

