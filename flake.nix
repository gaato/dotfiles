{
  description = "gaato dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    homeModules = {
      gaato = import ./home/gaato.nix;
      cli = import ./home/modules/cli.nix;
      fish = import ./home/modules/fish.nix;
      git = import ./home/modules/git.nix;
    };

    homeConfigurations.gaato = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        ./home/gaato.nix
      ];
    };
  };
}
