{ ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/fish.nix
    ./modules/git.nix
  ];

  home.username = "gaato";
  home.homeDirectory = "/home/gaato";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
