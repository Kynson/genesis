{
  description = "Genesis server configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";
  };

  outputs = { nixos-raspberrypi, disko }@inputs: 
    let 
      system = "aarch64-linux";
      hostName = "genesis";
    in {
      nixosConfigurations.${hostName} = nixos-raspberrypi.lib.nixosSystem {
        inherit system;
        # Pass all inputs to the modules below for easy access.
        specialArgs = { 
          inherit inputs;
          inherit hostName;
        };
        modules = [
          ./configuration.nix

          disko.nixosModules.disko
          ./disk-configuration.nix
        ];
      };
    };
}

