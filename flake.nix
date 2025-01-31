{
  description = "My NixOS Configuration in a Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:rycee/home-manager";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux"; # Set your system architecture (change if needed)
    in {
      # Define NixOS configuration
      nixosConfigurations = {
        tom = nixpkgs.lib.nixosSystem {
          system = system;
          modules = [
            ./configuration.nix  # Point to your system config file
          ];

          # Any extra configurations you may need
          specialArgs = {
            inherit system;
          };
        };
      };

      # Define Home Manager configuration for user `tom`
      homeConfigurations = {
        tom = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          homeDirectory = "/home/tom";  # Set the user's home directory
        };
      };
    };
}

