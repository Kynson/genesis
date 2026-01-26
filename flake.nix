{
  description = "Genesis server configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-raspberrypi.url = "github:nvmd/nixos-raspberrypi/main";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixos-raspberrypi, disko, sops-nix, ... }@inputs: 
    let 
      system = "aarch64-linux";
      hostName = "genesis";
    in {
      nixosConfigurations.${hostName} = nixos-raspberrypi.lib.nixosSystem {
        inherit system;
        # Pass all inputs to the modules below for easy access.
        specialArgs = inputs // { inherit hostName; };
        modules = [
          ./configuration.nix

          sops-nix.nixosModules.sops

          disko.nixosModules.disko
          ./disk-configuration.nix
        ];
      };
    };
}

