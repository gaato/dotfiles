{ pkgs, ... }:

{
  home.packages = with pkgs; [
    fd
    ghq
    jq
    mise
    ripgrep
  ];
}
