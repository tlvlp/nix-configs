{
    description = "Nixos configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            # Ensure that home-manager uses the same dependency versions as the other flakes.
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... } @ inputs : {

        nixosConfigurations.tux = nixpkgs.lib.nixosSystem {
            
            # System architecture (to select the correct variant form pkgs)
            system = "x86_64-linux";
            
            # Pass down all the inputs as `specialArgs` to the sub-modules
            specialArgs = { inherit inputs; };

            # Selected flakes and nix configs
            modules = [
                ./configuration.nix
                inputs.home-manager.nixosModules.default
            ];  
        };
    };
}