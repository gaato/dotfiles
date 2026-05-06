{
  description = "gaato dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, catppuccin, plasma-manager, ... }: {
    homeModules = {
      gaato = {
        imports = [
          catppuccin.homeModules.catppuccin
          plasma-manager.homeModules.plasma-manager
          ./home/gaato.nix
        ];
      };
      cli = import ./home/modules/cli.nix;
      fish = import ./home/modules/fish.nix;
      fonts = import ./home/modules/fonts.nix;
      git = import ./home/modules/git.nix;
      plasma = import ./home/modules/plasma.nix;
      theme = import ./home/modules/theme.nix;
    };

    homeConfigurations.gaato = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        catppuccin.homeModules.catppuccin
        plasma-manager.homeModules.plasma-manager
        ./home/gaato.nix
      ];
    };
  };
}
