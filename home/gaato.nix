{ ... }:

{
  imports = [
    ./modules/cli.nix
    ./modules/fish.nix
    ./modules/fonts.nix
    ./modules/git.nix
    ./modules/konsole.nix
    ./modules/plasma.nix
    ./modules/theme.nix
  ];

  home.username = "gaato";
  home.homeDirectory = "/home/gaato";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
