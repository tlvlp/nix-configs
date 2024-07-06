{
    description = "Nixos configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ self, nixpkgs, ... } : {
        nixosConfigurations.default = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; };
            modules = [
                ./configuration.nix
                inputs.home-manager.nixosModules.default
            ];  
        };
    };
}