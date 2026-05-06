{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      ${pkgs.mise}/bin/mise activate fish | source
    '';
  };
}
