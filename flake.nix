{
  description = "My Home Manager standalone configuration";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-25.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nur,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";

      config = {
        allowUnfree = true;
        nix.settings = {
          auto-optimise-store = true; # To optimise manually: nix-store --optimise
        };
      };

      overlays = [
        (self: super: {
          unstable = import nixpkgs-unstable {
            inherit system config;
          };

          nur = import nur {
            pkgs = self;
          };
        })
      ];

      pkgs = import nixpkgs {
        inherit system config overlays;
      };
    in
    {
      homeConfigurations."nas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home.nix
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        # extraSpecialArgs = {
        #   inherit x;
        # };
      };
    };
}
